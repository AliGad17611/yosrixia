import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yosrixia/core/error/failure.dart';
import 'package:yosrixia/features/child/profile/data/models/child_profile_model.dart';
import 'package:yosrixia/features/child/profile/data/repo/profile_repo.dart';

part 'child_info_state.dart';

class ChildInfoCubit extends Cubit<ChildInfoState> {
  ChildInfoCubit({required ProfileRepo profileRepo})
      : _profileRepo = profileRepo,
        super(ChildInfoInitial());
  final ProfileRepo _profileRepo;
  Future<void> fetchChildInfo() async {
    emit(ChildInfoLoading());

    final result = await _profileRepo.getChildProfile();
    result.fold(
      (failure) => emit(ChildInfoError(failure: failure)),
      (childProfileModel) => emit(ChildInfoLoaded(childProfileModel: childProfileModel)),
    );
  }
}
