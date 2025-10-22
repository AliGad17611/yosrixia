part of 'doctor_profile_cubit.dart';

sealed class DoctorProfileState extends Equatable {
  const DoctorProfileState();

  @override
  List<Object> get props => [];
}

final class DoctorProfileInitial extends DoctorProfileState {}

final class DoctorProfileLoading extends DoctorProfileState {}

final class DoctorProfileLoaded extends DoctorProfileState {
  final DoctorProfileModel doctorProfileModel;

  const DoctorProfileLoaded({required this.doctorProfileModel});

  @override
  List<Object> get props => [doctorProfileModel];
}

final class DoctorProfileFailure extends DoctorProfileState {
  final Failure failure;

  const DoctorProfileFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
