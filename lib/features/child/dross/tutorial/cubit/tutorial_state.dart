abstract class TutorialState {}

class TutorialInitial extends TutorialState {}

class TutorialLoading extends TutorialState {}

class TutorialVisible extends TutorialState {
  final int currentIndex;
  final bool isLastStep;

  TutorialVisible({required this.currentIndex, required this.isLastStep});
}

class TutorialCompleted extends TutorialState {}

class TutorialError extends TutorialState {
  final String error;

  TutorialError({required this.error});
}
