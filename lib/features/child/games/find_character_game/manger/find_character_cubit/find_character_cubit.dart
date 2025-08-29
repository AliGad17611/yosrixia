import 'dart:developer' as debug;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';
import 'package:yosrixia/core/helper/global_variable.dart';
import 'package:yosrixia/features/child/games/find_character_game/manger/helper/images_list.dart';
import 'package:yosrixia/features/child/games/find_character_game/manger/models/character_position.dart';

part 'find_character_state.dart';

class FindCharacterCubit extends Cubit<FindCharacterState> {
  FindCharacterCubit() : super(FindCharacterInitial());

  final Random _random = Random();
  List<String> showedCharacters = [];

  /// Initialize a new game with random character and background
  void initializeGame(double screenWidth, double screenHeight) {
    emit(FindCharacterLoading());
    navigateToNextScreen(screenWidth, screenHeight);
  }

  void navigateToNextScreen(double screenWidth, double screenHeight) {
    try {
      debug.log("showedCharacters: $showedCharacters");
      // Select random character from list
      final currentCharacter = getRandomCharacter();
      // Select random background image from list
      final backgroundImage = imagesList[_random.nextInt(imagesList.length)];
      // Generate character positions
      final characterPositions = _generateCharacterPositions(screenWidth, screenHeight);

      emit(FindCharacterGameState(
        currentCharacter: currentCharacter,
        backgroundImage: backgroundImage,
        remainingCharacters: 4,
        characterPositions: characterPositions,
      ));
    } catch (e) {
      emit(FindCharacterError(
          message: 'Failed to initialize game: ${e.toString()}'));
    }
  }

  /// Reset the game with new character and positions
  void resetGame(double screenWidth, double screenHeight) {
    initializeGame(screenWidth, screenHeight);
  }

  void resetCharactersPositions(double screenWidth, double screenHeight) {
    // re-generate character positions
    final characterPositions = _generateCharacterPositions(screenWidth, screenHeight);
    final currentState = state;

    if (currentState is FindCharacterGameState) {
      emit(currentState.copyWith(
          characterPositions: characterPositions, remainingCharacters: 4));
    }
  }

  /// Get random character from list
  String getRandomCharacter() {
    String currentCharacter;
    do {
      currentCharacter = allArabicChars[_random.nextInt(allArabicChars.length)];
    } while (showedCharacters.contains(currentCharacter));
    showedCharacters.add(currentCharacter);
    return currentCharacter;
  }

  /// Generate random positions for characters on screen
  List<CharacterPosition> _generateCharacterPositions(double screenWidth, double screenHeight) {
    final characterPositions = <CharacterPosition>[];

    // Define safe areas to avoid overlapping with title
    const safeTop = 200.0; // Below the title and counter
    const safeBottom = 100.0;
    const safeLeft = 10.0;
    const safeRight = 20.0;

    for (int i = 0; i < 4; i++) {
      double left, top;
      bool validPosition = false;
      int attempts = 0;

      do {
        left = safeLeft +
            _random.nextDouble() * (screenWidth - safeRight - safeLeft - 20);
        top = safeTop +
            _random.nextDouble() * (screenHeight - safeTop - safeBottom - 60);

        // Check if position overlaps with existing characters
        validPosition = !characterPositions.any((pos) =>
            (left - pos.left).abs() < 80 && (top - pos.top).abs() < 80);

        attempts++;
      } while (!validPosition && attempts < 20);

      characterPositions.add(CharacterPosition(
        id: i,
        left: left,
        top: top,
        isVisible: true,
      ));
    }

    return characterPositions;
  }

  /// Handle character tap - hide character and update remaining count
  void onCharacterTapped(double screenWidth, double screenHeight, int characterId) {
    final currentState = state;
    if (currentState is! FindCharacterGameState) return;

    try {
      // Find the character position and hide it
      final updatedPositions = currentState.characterPositions.map((pos) {
        if (pos.id == characterId && pos.isVisible) {
          return pos.copyWith(isVisible: false);
        }
        return pos;
      }).toList();

      final newRemainingCount = currentState.remainingCharacters - 1;

      // Check if there is no remaining character, navigate to next screen
      if (newRemainingCount <= 0) {
        if (showedCharacters.length == 3) {
          // game completed
          emit(FindCharacterSuccess(
            completedCharacter: showedCharacters.last,
            totalCharactersFound: showedCharacters.length,
          ));
        } else {
        navigateToNextScreen(screenWidth, screenHeight);
        }
      } else {
        emit(currentState.copyWith(
          characterPositions: updatedPositions,
          remainingCharacters: newRemainingCount,
        ));
      }
    } catch (e) {
      emit(FindCharacterError(
          message: 'Failed to process character tap: ${e.toString()}'));
    }
  }

  /// Get current game progress as percentage
  double getGameProgress() {
    final currentState = state;
    if (currentState is FindCharacterGameState) {
      return ((4 - currentState.remainingCharacters) / 4.0) * 100;
    }
    return 0.0;
  }

  /// Check if a specific character position is visible
  bool isCharacterVisible(int characterId) {
    final currentState = state;
    if (currentState is FindCharacterGameState) {
      final position = currentState.characterPositions.firstWhere(
          (pos) => pos.id == characterId,
          orElse: () => const CharacterPosition(
              id: -1, left: 0, top: 0, isVisible: false));
      return position.isVisible;
    }
    return false;
  }
}
