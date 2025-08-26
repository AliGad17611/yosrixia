import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';
import 'package:yosrixia/core/helper/global_variable.dart';
import 'package:yosrixia/features/child/games/find_character_game/manger/helper/images_list.dart';
import 'package:yosrixia/features/child/games/find_character_game/manger/models/character_position.dart';

part 'find_character_state.dart';

class FindCharacterCubit extends Cubit<FindCharacterState> {
  FindCharacterCubit() : super(FindCharacterInitial());

  final Random _random = Random();

  /// Initialize a new game with random character and background
  void initializeGame(BuildContext context) {
    try {
      emit(FindCharacterLoading());

      // Select random character and background
      final currentCharacter =
          allArabicChars[_random.nextInt(allArabicChars.length)];
      final backgroundImage = imagesList[_random.nextInt(imagesList.length)];

      // Generate character positions
      final characterPositions = _generateCharacterPositions(context);

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

  /// Generate random positions for characters on screen
  List<CharacterPosition> _generateCharacterPositions(BuildContext context) {
    final characterPositions = <CharacterPosition>[];
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
  void onCharacterTapped(int characterId) {
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

      // Check if game is completed
      if (newRemainingCount <= 0) {
        emit(currentState.copyWith(
          characterPositions: updatedPositions,
          remainingCharacters: newRemainingCount,
          isGameCompleted: true,
        ));
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

  /// Reset the game with new character and positions
  void resetGame(BuildContext context) {
    initializeGame(context);
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
