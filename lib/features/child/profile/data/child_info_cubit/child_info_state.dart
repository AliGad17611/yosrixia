part of 'child_info_cubit.dart';

sealed class ChildInfoState extends Equatable {
  const ChildInfoState();

  @override
  List<Object> get props => [];
}

final class ChildInfoInitial extends ChildInfoState {}

final class ChildInfoLoading extends ChildInfoState {}

final class ChildInfoLoaded extends ChildInfoState {
  final ChildInfoModel childInfoModel;
  const ChildInfoLoaded(this.childInfoModel);
}

final class ChildInfoError extends ChildInfoState {
  final String errorMessage;
  const ChildInfoError(this.errorMessage);
}
