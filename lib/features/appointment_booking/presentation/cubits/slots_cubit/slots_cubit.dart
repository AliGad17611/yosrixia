import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/error/failure.dart';
import 'package:yosrixia/core/logger/app_logger.dart';
import 'package:yosrixia/core/success/success.dart';
import 'package:yosrixia/features/appointment_booking/data/models/slot_model.dart';
import 'package:yosrixia/features/appointment_booking/data/repo/slots_repo.dart';
import 'package:yosrixia/features/child/profile/data/repo/profile_repo.dart';
part 'slots_state.dart';

class SlotsCubit extends Cubit<SlotsState> {
  SlotsCubit({required SlotsRepo slotsRepo, required ProfileRepo profileRepo, required FirebaseAuth firebaseAuth}) : _slotsRepo = slotsRepo, _profileRepo = profileRepo, _firebaseAuth = firebaseAuth, super(SlotsInitial());
  final SlotsRepo _slotsRepo;
  final ProfileRepo _profileRepo;
  final FirebaseAuth _firebaseAuth;
  //* get available slots
  Future<void> fetchSlots(String doctorId) async {
    emit(SlotsLoading());
    final result =  _slotsRepo.getAvailableSlotsStream(doctorId);
    result.listen((result) {
      result.fold(
        (failure) => emit(SlotsError(failure: failure)),
        (slots) => emit(SlotsLoaded(slots: slots)),
      );
    });
  }

  //* book slot
  Future<void> bookSlot(String slotId, String childId, String childName, String childPhone) async {
    emit(SlotsLoading());
    final result = await _slotsRepo.bookSlot(slotId, childId, childName, childPhone);
    result.fold(
      (failure) => emit(SlotsError(failure: failure)),
      (success) => emit(SlotsBooked(success: success)),
    );
  }

  //* add new slot
  Future<void> addSlot(DateTime dateTime) async {
    emit(SlotsLoading());
    final doctorProfile = await _profileRepo.getDoctorProfile();
     AppLogger.logInfo('doctorProfile: $doctorProfile');
    doctorProfile.fold(
      (failure) => emit(SlotsError(failure: failure)),
      (doctorProfile) async {
        final slot = SlotModel(
          id: '',
          doctorId: _firebaseAuth.currentUser?.uid ?? '',
          doctorName: doctorProfile.name,
          dateTime: Timestamp.fromDate(dateTime),
          isAvailable: true,
          bookedBy: null,
          bookedByName: null,
          bookedByPhone: null,
        );
        AppLogger.logInfo('slot: $slot');
        final result = await _slotsRepo.addSlot(slot);
        AppLogger.logInfo('result: $result');
        result.fold(
          (failure) => emit(SlotsError(failure: failure)),
          (success) => emit(SlotsAdded(success: success)),
        );
      }
    );
  }

  //* delete slot
  Future<void> deleteSlot(String slotId) async {
    emit(SlotsLoading());
    final result = await _slotsRepo.deleteSlot(slotId);
    result.fold(
      (failure) => emit(SlotsError(failure: failure)),
      (success) => emit(SlotsDeleted(success: success)),
    );
  }

  //* update slot
  Future<void> updateSlot(SlotModel slot) async {
    emit(SlotsLoading());
    final result = await _slotsRepo.updateSlot(slot);
    result.fold(
      (failure) => emit(SlotsError(failure: failure)),
      (success) => emit(SlotsUpdated(success: success)),
    );
  }
}
