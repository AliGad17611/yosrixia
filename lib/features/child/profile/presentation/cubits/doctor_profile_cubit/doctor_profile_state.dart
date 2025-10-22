part of 'doctor_profile_cubit.dart';

sealed class DoctorProfileState extends Equatable {
  const DoctorProfileState();

  @override
  List<Object> get props => [];
}

final class DoctorProfileInitial extends DoctorProfileState {}

final class DoctorProfileLoading extends DoctorProfileState {}

final class DoctorProfileLoaded extends DoctorProfileState {
  final DoctorModel doctorModel;

  const DoctorProfileLoaded({required this.doctorModel});

  @override
  List<Object> get props => [doctorModel];
}

final class DoctorProfileFailure extends DoctorProfileState {
  final String error;

  const DoctorProfileFailure({required this.error});

  @override
  List<Object> get props => [error];
}
