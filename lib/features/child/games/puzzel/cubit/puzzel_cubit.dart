import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/features/child/games/puzzel/cubit/puzzle_state.dart';

class PuzzleCubit extends Cubit<PuzzleState> {
  final Map<String, List<String>> letterPartsMap;
  final Set<String> _usedLetters = {};
  late String currentLetter;
  late List<String> shuffledParts;
  Map<int, String?> placedImages = {0: null, 1: null, 2: null, 3: null};

  PuzzleCubit(this.letterPartsMap) : super(PuzzleInitial());

  void loadNextLetter() {
    final unused =
        letterPartsMap.keys.where((l) => !_usedLetters.contains(l)).toList();
    if (unused.isEmpty) {
      emit(PuzzleCompleted());
      return;
    }

    currentLetter = unused[Random().nextInt(unused.length)];
    _usedLetters.add(currentLetter);

    shuffledParts = List.of(letterPartsMap[currentLetter]!);
    shuffledParts.shuffle();
    placedImages = {0: null, 1: null, 2: null, 3: null};

    emit(PuzzleLoaded(
        currentLetter, List.of(shuffledParts), Map.of(placedImages)));
  }

  void placeImage(int index, String imagePath) {
    if (imagePath.contains((index + 1).toString())) {
      placedImages[index] = imagePath;
      emit(PuzzleLoaded(
          currentLetter, List.of(shuffledParts), Map.of(placedImages)));
    }
  }
}
