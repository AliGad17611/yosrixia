import 'dart:math';
import 'dart:ui';
import 'dart:developer' as dev;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';
import 'handwriting_state.dart';

class HandwritingCubit extends Cubit<HandwritingState> {
  final DigitalInkRecognizerModelManager _modelManager =
      DigitalInkRecognizerModelManager();
  final String languageCode = 'ar';
  late final DigitalInkRecognizer _digitalInkRecognizer;
  late Ink _ink;

  final List<String> _arabicCharacters = [
    'أ',
    'ب',
    'ت',
    'ث',
    'ج',
    'ح',
    'خ',
    'د',
    'ذ',
    'ر',
    'ز',
    'س',
    'ش',
    'ص',
    'ض',
    'ط',
    'ظ',
    'ع',
    'غ',
    'ف',
    'ق',
    'ك',
    'ل',
    'م',
    'ن',
    'ه',
    'و',
    'ي'
  ];
  final Set<String> _usedCharacters = {};

  HandwritingCubit() : super(const HandwritingState()) {
    _digitalInkRecognizer = DigitalInkRecognizer(languageCode: languageCode);
    _ink = Ink();
    checkIfModelDownloaded();
  }

  @override
  Future<void> close() {
    _digitalInkRecognizer.close();
    return super.close();
  }

  Future<void> checkIfModelDownloaded() async {
    try {
      final isDownloaded = await _modelManager.isModelDownloaded(languageCode);
      emit(state.copyWith(isModelDownloaded: isDownloaded));
      if (!isDownloaded) {
        await downloadModel();
      } else {
        showRandomLetter();
      }
    } catch (e) {
      emit(state.copyWith(error: 'Error checking model: $e'));
    }
  }

  Future<void> downloadModel() async {
    emit(state.copyWith(isProcessing: true));
    try {
      await _modelManager.downloadModel(languageCode);
      emit(state.copyWith(isModelDownloaded: true, isProcessing: false));
      showRandomLetter();
    } catch (e) {
      emit(state.copyWith(
          error: 'Error downloading model: $e', isProcessing: false));
    }
  }

  void startNewStroke(Offset point) {
    emit(state.copyWith(currentPoints: []));
    addPointToStroke(point);
  }

  void addPointToStroke(Offset point) {
    final strokePoint = StrokePoint(
      x: point.dx,
      y: point.dy,
      t: DateTime.now().millisecondsSinceEpoch,
    );

    final updatedPoints = List<StrokePoint>.from(state.currentPoints)
      ..add(strokePoint);
    emit(state.copyWith(currentPoints: updatedPoints));
  }

  void endStroke() {
    if (state.currentPoints.isNotEmpty) {
      final stroke = Stroke()..points = [...state.currentPoints];
      final updatedStrokes = List<Stroke>.from(state.strokes)..add(stroke);
      _ink.strokes = updatedStrokes;
      emit(state.copyWith(strokes: updatedStrokes));
    }
  }

  Future<String> recognizeText() async {
    if (state.strokes.isEmpty || !state.isModelDownloaded) return '';
    try {
      emit(state.copyWith(isProcessing: true));
      final candidates = await _digitalInkRecognizer.recognize(_ink);
      final recognized = candidates.isNotEmpty ? candidates[0].text : '';
      emit(state.copyWith(isProcessing: false));
      return recognized;
    } catch (e) {
      emit(state.copyWith(error: 'Recognition error: $e', isProcessing: false));
      return '';
    }
  }

  void clearInk() {
    _ink.strokes = [];
    emit(state.copyWith(strokes: [], currentPoints: [], isCorrect: false));
  }

  void showRandomLetter() {
    if (_usedCharacters.length == _arabicCharacters.length) {
      emit(state.copyWith(isfinished: true));
      return;
    }

    final random = Random();
    String nextChar;
    do {
      nextChar = _arabicCharacters[random.nextInt(_arabicCharacters.length)];
    } while (_usedCharacters.contains(nextChar));

    _usedCharacters.add(nextChar);
    emit(state.copyWith(
        currentLetter: nextChar,
        strokes: [],
        currentPoints: [],
        isCorrect: false));
  }

  void nextLetter() async {
    final recognized = await recognizeText();
    dev.log(recognized);
    if (recognized == state.currentLetter) {
      emit(state.copyWith(isCorrect: true));
      clearInk();
      showRandomLetter();
    } else {
      emit(state.copyWith(isCorrect: false));
    }
  }

  void resetLetters() {
    _usedCharacters.clear();
    emit(state.copyWith(
        currentLetter: '', strokes: [], currentPoints: [], isCorrect: false));
  }
}
