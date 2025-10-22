part of 'child_info_cubit.dart';

sealed class ChildInfoState extends Equatable {
  const ChildInfoState();

  @override
  List<Object> get props => [];
}

final class ChildInfoInitial extends ChildInfoState {}

final class ChildInfoLoading extends ChildInfoState {}

final class ChildInfoLoaded extends ChildInfoState {
  final ChildProfileModel childProfileModel;
  const ChildInfoLoaded({required this.childProfileModel});
}

final class ChildInfoError extends ChildInfoState {
  final Failure failure;
  const ChildInfoError({required this.failure});

  @override
  List<Object> get props => [failure];
}
