abstract class PuzzleState {}

class PuzzleInitial extends PuzzleState {}

class PuzzleLoaded extends PuzzleState {
  final String letter;
  final List<String> shuffledImages;
  final Map<int, String?> placedImages;

  PuzzleLoaded(this.letter, this.shuffledImages, this.placedImages);
}

class PuzzleCompleted extends PuzzleState {}
