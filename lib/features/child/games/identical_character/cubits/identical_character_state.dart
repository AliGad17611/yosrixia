part of 'identical_character_cubit.dart';

sealed class IdenticalCharacterState extends Equatable {
  const IdenticalCharacterState();

  @override
  List<Object> get props => [];
}

final class IdenticalCharacterInitial extends IdenticalCharacterState {}

final class IdenticalCharacterGameState extends IdenticalCharacterState {
  final List<String> characters;
  final List<bool> flippedCards;
  final List<bool> matchedCards;
  final List<int> currentFlippedIndexes;
  final bool isProcessing;

  const IdenticalCharacterGameState({
    required this.characters,
    required this.flippedCards,
    required this.matchedCards,
    required this.currentFlippedIndexes,
    this.isProcessing = false,
  });

  @override
  List<Object> get props => [
        characters,
        flippedCards,
        matchedCards,
        currentFlippedIndexes,
        isProcessing,
      ];

  IdenticalCharacterGameState copyWith({
    List<String>? characters,
    List<bool>? flippedCards,
    List<bool>? matchedCards,
    List<int>? currentFlippedIndexes,
    bool? isProcessing,
  }) {
    return IdenticalCharacterGameState(
      characters: characters ?? this.characters,
      flippedCards: flippedCards ?? this.flippedCards,
      matchedCards: matchedCards ?? this.matchedCards,
      currentFlippedIndexes:
          currentFlippedIndexes ?? this.currentFlippedIndexes,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }

  // check if the game is finished
  bool get isGameFinished => matchedCards.every((matched) => matched);
}
