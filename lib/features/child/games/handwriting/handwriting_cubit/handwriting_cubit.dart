// Cubit
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';
import 'package:yosrixia/features/child/games/handwriting/handwriting_cubit/handwriting_state.dart';

class HandwritingCubit extends Cubit<HandwritingState> {
  final DigitalInkRecognizerModelManager _modelManager = DigitalInkRecognizerModelManager();
  final String languageCode = 'ar';
  late DigitalInkRecognizer _digitalInkRecognizer;
  late Ink _ink;

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
      }
    } catch (e) {
      emit(state.copyWith(error: 'Error checking model: $e'));
    }
  }

  Future<void> downloadModel() async {
    emit(state.copyWith(isProcessing: true));
    try {
      await _modelManager.downloadModel(languageCode);
      emit(state.copyWith(
        isModelDownloaded: true,
        isProcessing: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: 'Error downloading model: $e',
        isProcessing: false,
      ));
    }
  }

  void startNewStroke(Offset point) {
    emit(state.copyWith(currentPoints: []));
    addPointToStroke(point);
  }

  void addPointToStroke(Offset point) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final strokePoint = StrokePoint(
      x: point.dx,
      y: point.dy,
      t: timestamp,
    );
    
    final updatedPoints = List<StrokePoint>.from(state.currentPoints)..add(strokePoint);
    emit(state.copyWith(currentPoints: updatedPoints));
  }

  void endStroke() {
  if (state.currentPoints.isNotEmpty) {
    // Create a new Stroke
    final stroke = Stroke();
    // Add all points to the stroke
    stroke.points = [...state.currentPoints];
     // Add to list of strokes
    final updatedStrokes = List<Stroke>.from(state.strokes)..add(stroke);
    _ink.strokes = updatedStrokes;
    emit(state.copyWith(strokes: updatedStrokes));
  }
}

  Future<void> recognizeText() async {
    if (state.strokes.isEmpty || !state.isModelDownloaded) return;
    
    emit(state.copyWith(isProcessing: true));
    
    try {
      final List<RecognitionCandidate> candidates = await _digitalInkRecognizer.recognize(_ink);
      
      final recognizedText = candidates.isNotEmpty 
          ? candidates[0].text 
          : 'No text recognized';
          
      emit(state.copyWith(
        recognizedText: recognizedText,
        isProcessing: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: 'Recognition error: $e',
        isProcessing: false,
      ));
    }
  }

  void clearInk() {
    _ink.strokes = [];
    emit(const HandwritingState());
  }
}
