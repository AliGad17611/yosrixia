import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yosrixia/features/child/doctors/models/doctor_model.dart';

part 'doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  DoctorProfileCubit({required this.firebaseInstance}) : super(DoctorProfileInitial());
  final FirebaseAuth firebaseInstance ;

  Future<void> getDoctorProfile() async {
    emit(DoctorProfileLoading());
    try {
      // Get current user ID
      final currentUserId = firebaseInstance.currentUser?.uid;

      if (currentUserId == null) {
        emit(const DoctorProfileFailure(error: 'User not authenticated'));
        return;
      }

      log('Fetching doctor profile for user: $currentUserId');

      // Fetch doctor data from Firestore
      DocumentSnapshot doctorDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .get();

      if (doctorDoc.exists) {
        Map<String, dynamic> doctorData =
            doctorDoc.data() as Map<String, dynamic>;

        DoctorModel doctorModel = DoctorModel(
          email: doctorData['email'] ?? '',
          name: doctorData['name'] ?? '',
          imageUrl: doctorData['imageUrl'] ?? '',
          number: doctorData['number'] ?? '',
        );

        log("Doctor profile loaded - name: ${doctorModel.name}, email: ${doctorModel.email}");
        emit(DoctorProfileLoaded(doctorModel: doctorModel));
      } else {
        emit(const DoctorProfileFailure(error: 'Doctor profile not found'));
      }
    } catch (e) {
      log('Error loading doctor profile: $e');
      emit(DoctorProfileFailure(error: e.toString()));
    }
  }

  Future<void> updateDoctorProfile({
    required String name,
    required String number,
  }) async {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser?.uid;

      if (currentUserId == null) {
        emit(const DoctorProfileFailure(error: 'User not authenticated'));
        return;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .update({
        'name': name,
        'number': number,
      });

      // Reload the profile
      await getDoctorProfile();
    } catch (e) {
      log('Error updating doctor profile: $e');
      emit(DoctorProfileFailure(error: e.toString()));
    }
  }
}
