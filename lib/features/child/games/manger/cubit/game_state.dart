class GameState {}

class InitialGameState extends GameState {
  
}

class CorrectAnswerState extends GameState {
  final int questionIndex;
  final int selectedIndex;
  CorrectAnswerState(
      {required this.questionIndex, required this.selectedIndex});
}

class WrongAnswerState extends GameState {
  final int questionIndex;
  final int selectedIndex;
  final int correctAnswerIndex;
  WrongAnswerState(
      {required this.questionIndex,
      required this.selectedIndex,
      required this.correctAnswerIndex});
}

class NextQuestionState extends GameState {
  final int index;
  NextQuestionState({required this.index});
}

class FinalScoreState extends GameState {
  final int score;
  FinalScoreState({required this.score});
}
