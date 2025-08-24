import 'dart:math';

import 'package:equatable/equatable.dart';
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/helper/global_variable.dart';

part 'identical_character_state.dart';

class IdenticalCharacterCubit extends Cubit<IdenticalCharacterState> {
  IdenticalCharacterCubit() : super(IdenticalCharacterInitial());

  Timer? _flipBackTimer;

  void initializeGame() {
    // Create pairs of characters for the matching game
    final random = Random();

    // pick 6 unique random characters
    final List<String> selected = [];
    while (selected.length < 6) {
      final char = allArabicChars[random.nextInt(allArabicChars.length)];
      if (!selected.contains(char)) {
        selected.add(char);
      }
    }

    // duplicate them to make pairs
    final List<String> characters = [...selected, ...selected];

    // Shuffle the characters
    characters.shuffle();

    emit(IdenticalCharacterGameState(
      characters: characters,
      flippedCards: List.filled(characters.length, false),
      matchedCards: List.filled(characters.length, false),
      currentFlippedIndexes: const [],
    ));
  }

  void flipCard(int index) {
    final currentState = state;
    if (currentState is! IdenticalCharacterGameState) return;

    // Don't allow flipping if processing or card is already matched
    if (currentState.isProcessing ||
        currentState.matchedCards[index] ||
        currentState.flippedCards[index]) {
      return;
    }

    // Don't allow more than 2 cards to be flipped
    if (currentState.currentFlippedIndexes.length >= 2) {
      return;
    }

    // Cancel any pending flip back timer
    _flipBackTimer?.cancel();

    final newFlippedCards = List<bool>.from(currentState.flippedCards);
    final newCurrentFlippedIndexes =
        List<int>.from(currentState.currentFlippedIndexes);

    newFlippedCards[index] = true;
    newCurrentFlippedIndexes.add(index);

    emit(currentState.copyWith(
      flippedCards: newFlippedCards,
      currentFlippedIndexes: newCurrentFlippedIndexes,
    ));

    // Check if we have two cards flipped
    if (newCurrentFlippedIndexes.length == 2) {
      _checkMatch();
    }
  }

  void _checkMatch() {
    final currentState = state;
    if (currentState is! IdenticalCharacterGameState) return;

    emit(currentState.copyWith(isProcessing: true));

    final firstIndex = currentState.currentFlippedIndexes[0];
    final secondIndex = currentState.currentFlippedIndexes[1];
    final firstCharacter = currentState.characters[firstIndex];
    final secondCharacter = currentState.characters[secondIndex];

    // Check if characters match
    if (firstCharacter == secondCharacter) {
      // Match found - mark cards as matched
      final newMatchedCards = List<bool>.from(currentState.matchedCards);
      newMatchedCards[firstIndex] = true;
      newMatchedCards[secondIndex] = true;

      emit(currentState.copyWith(
        matchedCards: newMatchedCards,
        currentFlippedIndexes: [],
        isProcessing: false,
      ));
    } else {
      // No match - flip cards back after delay
      _flipBackTimer = Timer(const Duration(milliseconds: 1000), () {
        _flipBackUnmatchedCards();
      });
    }
  }

  void _flipBackUnmatchedCards() {
    final currentState = state;
    if (currentState is! IdenticalCharacterGameState) return;

    final newFlippedCards = List<bool>.from(currentState.flippedCards);

    // Flip back the two unmatched cards
    for (final index in currentState.currentFlippedIndexes) {
      newFlippedCards[index] = false;
    }

    emit(currentState.copyWith(
      flippedCards: newFlippedCards,
      currentFlippedIndexes: [],
      isProcessing: false,
    ));
  }

  void restartGame() {
    _flipBackTimer?.cancel();
    initializeGame();
  }

  @override
  Future<void> close() {
    _flipBackTimer?.cancel();
    return super.close();
  }
}
