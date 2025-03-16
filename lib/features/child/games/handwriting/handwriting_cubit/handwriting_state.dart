// State
import 'package:equatable/equatable.dart';
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';

class HandwritingState extends Equatable {
  final List<Stroke> strokes;
  final List<StrokePoint> currentPoints;
  final String recognizedText;
  final bool isProcessing;
  final bool isModelDownloaded;
  final String error;

  const HandwritingState({
    this.strokes = const [],
    this.currentPoints = const [],
    this.recognizedText = '',
    this.isProcessing = false,
    this.isModelDownloaded = false,
    this.error = '',
  });

  HandwritingState copyWith({
    List<Stroke>? strokes,
    List<StrokePoint>? currentPoints,
    String? recognizedText,
    bool? isProcessing,
    bool? isModelDownloaded,
    String? error,
  }) {
    return HandwritingState(
      strokes: strokes ?? this.strokes,
      currentPoints: currentPoints ?? this.currentPoints,
      recognizedText: recognizedText ?? this.recognizedText,
      isProcessing: isProcessing ?? this.isProcessing,
      isModelDownloaded: isModelDownloaded ?? this.isModelDownloaded,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        strokes,
        currentPoints,
        recognizedText,
        isProcessing,
        isModelDownloaded,
        error,
      ];
}