part of 'slots_cubit.dart';

sealed class SlotsState extends Equatable {
  const SlotsState();

  @override
  List<Object> get props => [];
}

final class SlotsInitial extends SlotsState {}

final class SlotsLoading extends SlotsState {}

final class SlotsLoaded extends SlotsState {
  final List<SlotModel> slots;
  const SlotsLoaded({required this.slots});
}

final class SlotsBooked extends SlotsState {
  final Success success;
  const SlotsBooked({required this.success});

  @override
  List<Object> get props => [success];
}

final class SlotsAdded extends SlotsState {
  final Success success;
  const SlotsAdded({required this.success});

  @override
  List<Object> get props => [success];
}

final class SlotsDeleted extends SlotsState {
  final Success success;
  const SlotsDeleted({required this.success});

  @override
  List<Object> get props => [success];
}

final class SlotsUpdated extends SlotsState {
  final Success success;
  const SlotsUpdated({required this.success});

  @override
  List<Object> get props => [success];
}

final class SlotsError extends SlotsState {
  final Failure failure;
  const SlotsError({required this.failure});

  @override
  List<Object> get props => [failure];
}
