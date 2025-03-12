class ChildOnboardingState {}

class ChildOnboardingOverviewState extends ChildOnboardingState {
  final int index;
  ChildOnboardingOverviewState({required this.index});
}

class ChildOnboardingExamState extends ChildOnboardingState {
  final int questionIndex;
  ChildOnboardingExamState({this.questionIndex = 0});
}
