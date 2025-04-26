import 'package:equatable/equatable.dart';
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';

class HandwritingState extends Equatable {
  final bool isModelDownloaded;
  final bool isProcessing;
  final String error;
  final List<Stroke> strokes;
  final List<StrokePoint> currentPoints;
  final String currentLetter;
  final bool isCorrect;
  final bool isfinished;

  const HandwritingState( {
    this.isfinished = false,
    this.isModelDownloaded = false,
    this.isProcessing = false,
    this.error = '',
    this.strokes = const [],
    this.currentPoints = const [],
    this.currentLetter = '',
    this.isCorrect = false,
  });

  HandwritingState copyWith({
    bool? isModelDownloaded,
    bool? isProcessing,
    String? error,
    List<Stroke>? strokes,
    List<StrokePoint>? currentPoints,
    String? currentLetter,
    bool? isCorrect,
    bool? isfinished,
  }) {
    return HandwritingState(
      isModelDownloaded: isModelDownloaded ?? this.isModelDownloaded,
      isProcessing: isProcessing ?? this.isProcessing,
      error: error ?? this.error,
      strokes: strokes ?? this.strokes,
      currentPoints: currentPoints ?? this.currentPoints,
      currentLetter: currentLetter ?? this.currentLetter,
      isCorrect: isCorrect ?? this.isCorrect,
      isfinished: isfinished ?? this.isfinished,
    );
  }

  @override
  List<Object?> get props => [
        isModelDownloaded,
        isProcessing,
        error,
        strokes,
        currentPoints,
        currentLetter,
        isCorrect,
        isfinished,
      ];
}

class NextCharacterState extends HandwritingState {
  final String nextCharacter;

  const NextCharacterState({required this.nextCharacter})
      : super(currentLetter: nextCharacter, isfinished: false);

  @override
  List<Object?> get props => [...super.props, nextCharacter];
}
