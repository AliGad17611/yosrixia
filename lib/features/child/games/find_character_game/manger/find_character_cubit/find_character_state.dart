part of 'find_character_cubit.dart';

sealed class FindCharacterState extends Equatable {
  const FindCharacterState();

  @override
  List<Object> get props => [];
}

final class FindCharacterInitial extends FindCharacterState {}

final class FindCharacterLoading extends FindCharacterState {}

final class FindCharacterGameState extends FindCharacterState {
  final String currentCharacter;
  final String backgroundImage;
  final int remainingCharacters;
  final List<CharacterPosition> characterPositions;
  final bool isGameCompleted;

  const FindCharacterGameState({
    required this.currentCharacter,
    required this.backgroundImage,
    required this.remainingCharacters,
    required this.characterPositions,
    this.isGameCompleted = false,
  });

  @override
  List<Object> get props => [
        currentCharacter,
        backgroundImage,
        remainingCharacters,
        characterPositions,
        isGameCompleted,
      ];

  FindCharacterGameState copyWith({
    String? currentCharacter,
    String? backgroundImage,
    int? remainingCharacters,
    List<CharacterPosition>? characterPositions,
    bool? isGameCompleted,
  }) {
    return FindCharacterGameState(
      currentCharacter: currentCharacter ?? this.currentCharacter,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      remainingCharacters: remainingCharacters ?? this.remainingCharacters,
      characterPositions: characterPositions ?? this.characterPositions,
      isGameCompleted: isGameCompleted ?? this.isGameCompleted,
    );
  }
}

final class FindCharacterSuccess extends FindCharacterState {
  final String completedCharacter;
  final int totalCharactersFound;

  const FindCharacterSuccess({
    required this.completedCharacter,
    required this.totalCharactersFound,
  });

  @override
  List<Object> get props => [completedCharacter, totalCharactersFound];
}

final class FindCharacterError extends FindCharacterState {
  final String message;

  const FindCharacterError({required this.message});

  @override
  List<Object> get props => [message];
}
