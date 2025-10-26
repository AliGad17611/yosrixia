import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yosrixia/features/child/doctors/models/doctor_model.dart';
import 'package:yosrixia/features/appointment_booking/data/models/slot_model.dart';

part 'doctor_details_state.dart';

class DoctorDetailsCubit extends Cubit<DoctorDetailsState> {
  DoctorDetailsCubit() : super(DoctorDetailsInitial());

  Stream<List<SlotModel>>? _slotsStream;

  void getDoctorDetails(String doctorId) async {
    log(doctorId);
    emit(DoctorDetailsLoading());
    try {
      DocumentSnapshot doctorDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(doctorId)
          .get();
      if (doctorDoc.exists) {
        Map<String, dynamic> doctorData =
            doctorDoc.data() as Map<String, dynamic>;
        DoctorModel doctorModel = DoctorModel(
          email: doctorData['email'] ?? '',
          name: doctorData['name'] ?? '',
          imageUrl: doctorData['imageUrl'] ?? '',
          number: doctorData['number'] ?? '',
          birthDate: doctorData['birthDate'],
          organization: doctorData['organization'],
          experience: doctorData['experience'],
          specialization: doctorData['specialization'],
          bio: doctorData['bio'],
        );
        log("name ${doctorModel.name}//email ${doctorModel.email}//imageUrl ${doctorModel.imageUrl}//number ${doctorModel.number}");

        // Fetch available slots
        _slotsStream = FirebaseFirestore.instance
            .collection('appointment_slots')
            .where('doctorId', isEqualTo: doctorId)
            .where('isAvailable', isEqualTo: true)
            .orderBy('dateTime', descending: false)
            .snapshots()
            .map((snapshot) => snapshot.docs
                .map((doc) => SlotModel.fromJson(doc.data(), id: doc.id))
                .toList());

        emit(DoctorDetailsLoaded(doctorModel: doctorModel));
      }
    } catch (e) {
      emit(DoctorDetailsFailure(error: e.toString()));
    }
  }

  Stream<List<SlotModel>>? getSlotsStream() {
    return _slotsStream;
  }

  Future<void> bookAppointment(String slotId, String childId, String childName,
      String childPhone) async {
    emit(DoctorDetailsLoading());
    try {
      await FirebaseFirestore.instance
          .collection('appointment_slots')
          .doc(slotId)
          .update({
        'bookedBy': childId,
        'bookedByName': childName,
        'bookedByPhone': childPhone,
        'isAvailable': false,
      });

      // Refresh doctor details to update the slots
      if (state is DoctorDetailsLoaded) {
        final currentState = state as DoctorDetailsLoaded;
        emit(DoctorDetailsLoaded(doctorModel: currentState.doctorModel));
      }
    } catch (e) {
      emit(DoctorDetailsFailure(error: e.toString()));
    }
  }
}
