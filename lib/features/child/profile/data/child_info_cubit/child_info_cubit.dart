import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yosrixia/features/child/profile/data/firestore_service.dart';
import 'package:yosrixia/features/child/profile/models/child_info_model.dart';

part 'child_info_state.dart';

class ChildInfoCubit extends Cubit<ChildInfoState> {
  ChildInfoCubit() : super(ChildInfoInitial());
  final FirestoreService firestoreService = FirestoreService();

  Future<void> fetchChildInfo() async {
    emit(ChildInfoLoading());
    try {
      ChildInfoModel childInfoModel = await firestoreService.getUserData();
      emit(ChildInfoLoaded(childInfoModel));
    } catch (e) {
      emit(ChildInfoError(e.toString()));
    }
  }
}
