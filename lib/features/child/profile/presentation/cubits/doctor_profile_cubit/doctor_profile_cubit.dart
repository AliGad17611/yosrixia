import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yosrixia/core/error/failure.dart';
import 'package:yosrixia/core/logger/app_logger.dart';
import 'package:yosrixia/features/child/profile/data/models/doctor_profile_model.dart';
import 'package:yosrixia/features/child/profile/data/repo/profile_repo.dart';

part 'doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  DoctorProfileCubit({required this.profileRepo})
      : super(DoctorProfileInitial());
  final ProfileRepo profileRepo;

  Future<void> getDoctorProfile() async {
    AppLogger.logInfo('Getting doctor profile');
    emit(DoctorProfileLoading());

    AppLogger.logInfo('Profile repo: $profileRepo');
    final result = await profileRepo.getDoctorProfile();
    AppLogger.logInfo('Doctor profile result: $result');
    result.fold(
      (failure) => emit(DoctorProfileFailure(failure: failure)),
      (doctorProfileModel) =>
          emit(DoctorProfileLoaded(doctorProfileModel: doctorProfileModel)),
    );
  }

  Future<void> updateDoctorProfile({
    required String name,
    required String number,
    required DateTime birthDate,
    required String organization,
    required String experience,
    String? imageUrl,
    String? email,
  }) async {
    AppLogger.logInfo('Updating doctor profile');
    // Get current state to retrieve existing values
    if (state is DoctorProfileLoaded) {
      final currentDoctor = (state as DoctorProfileLoaded).doctorProfileModel;

      final updatedDoctor = DoctorProfileModel(
        name: name,
        email: email ?? currentDoctor.email,
        number: number,
        imageUrl: imageUrl ?? currentDoctor.imageUrl,
        birthDate:
            '${birthDate.year}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}',
        organization: organization,
        experience: experience,
      );

      emit(DoctorProfileLoading());

      final result = await profileRepo.updateDoctorProfile(updatedDoctor);

      result.fold(
        (failure) => emit(DoctorProfileFailure(failure: failure)),
        (success) async {
          // After successful update, fetch the updated profile
          final profileResult = await profileRepo.getDoctorProfile();
          profileResult.fold(
            (failure) => emit(DoctorProfileFailure(failure: failure)),
            (doctorProfileModel) => emit(
                DoctorProfileLoaded(doctorProfileModel: doctorProfileModel)),
          );
        },
      );
    }
  }
}
