import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/error/failure.dart';
import 'package:yosrixia/core/success/success.dart';
import 'package:yosrixia/features/appointment_booking/data/models/slot_model.dart';
import 'package:yosrixia/features/appointment_booking/data/repo/slots_repo.dart';
part 'slots_state.dart';

class SlotsCubit extends Cubit<SlotsState> {
  SlotsCubit({required SlotsRepo slotsRepo}) : _slotsRepo = slotsRepo, super(SlotsInitial());
  final SlotsRepo _slotsRepo;

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
  Future<void> addSlot(SlotModel slot) async {
    emit(SlotsLoading());
    final result = await _slotsRepo.addSlot(slot);
    result.fold(
      (failure) => emit(SlotsError(failure: failure)),
      (success) => emit(SlotsAdded(success: success)),
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
