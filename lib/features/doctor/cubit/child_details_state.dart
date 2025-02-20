part of 'child_details_cubit.dart';

sealed class ChildDetailsState extends Equatable {
  const ChildDetailsState();

  @override
  List<Object> get props => [];
}

final class ChildDetailsInitial extends ChildDetailsState {}

final class ChildDetailsLoading extends ChildDetailsState {}

final class ChildDetailsLoaded extends ChildDetailsState {
  final ChildInfoModel childInfoModel;
  const ChildDetailsLoaded({required this.childInfoModel});
}

final class ChildDetailsError extends ChildDetailsState {
  final String error;
  const ChildDetailsError({required this.error});
}
