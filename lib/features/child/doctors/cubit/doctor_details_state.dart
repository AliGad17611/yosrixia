part of 'doctor_details_cubit.dart';


sealed class DoctorDetailsState extends Equatable {
  const DoctorDetailsState();

  @override
  List<Object> get props => [];
}

final class DoctorDetailsInitial extends DoctorDetailsState {}

final class DoctorDetailsLoading extends DoctorDetailsState {}

final class DoctorDetailsLoaded extends DoctorDetailsState {
  final DoctorModel doctorModel; 

  const DoctorDetailsLoaded({required this.doctorModel,});
}

final class DoctorDetailsFailure extends DoctorDetailsState {
  final String error;

  const DoctorDetailsFailure({required this.error});
}
  
