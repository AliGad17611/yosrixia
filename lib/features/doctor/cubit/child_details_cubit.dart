import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yosrixia/features/child/profile/models/child_info_model.dart';

part 'child_details_state.dart';

class ChildDetailsCubit extends Cubit<ChildDetailsState> {
  ChildDetailsCubit() : super(ChildDetailsInitial());

  void fetchChildDetails(String childId) async {
    emit(ChildDetailsLoading());
    try {
      DocumentSnapshot childDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(childId)
          .get();

      if (childDoc.exists) {
        Map<String, dynamic> childData =
            childDoc.data() as Map<String, dynamic>;
        ChildInfoModel childInfoModel = ChildInfoModel(
          name: childData['name'],
          imageUrl: childData['imageUrl'],
          country: childData['country'],
          birthDate: childData['birthDate'],
          gender: childData['gender'],
          number: childData['number'],
          email: childData['email'],
        );
        log("child name ${childInfoModel.name}//country ${childInfoModel.country}//birthDate ${childInfoModel.birthDate}//gender ${childInfoModel.gender}//number ${childInfoModel.number}");
        emit(ChildDetailsLoaded(childInfoModel: childInfoModel));
      }
    } catch (e) {
      emit(ChildDetailsError(error: e.toString()));
    }
  }
}
