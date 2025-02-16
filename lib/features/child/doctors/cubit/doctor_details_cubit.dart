import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yosrixia/features/child/doctors/models/doctor_model.dart';

part 'doctor_details_state.dart';

class DoctorDetailsCubit extends Cubit<DoctorDetailsState> {
  DoctorDetailsCubit() : super(DoctorDetailsInitial());

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
          email: doctorData['email'],
          name: doctorData['name'],
          imageUrl: doctorData['imageUrl'],
          number: doctorData['number'],
        );
        log("name ${doctorModel.name}//email ${doctorModel.email}//imageUrl ${doctorModel.imageUrl}//number ${doctorModel.number}");
        emit(DoctorDetailsLoaded(doctorModel: doctorModel));
      }
    } catch (e) {
      emit(DoctorDetailsFailure(error: e.toString()));
    }
  }
}

