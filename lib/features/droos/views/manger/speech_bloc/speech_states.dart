import 'package:flutter/material.dart';

class SpeechState {
  final bool isInitialized;
  final bool isListening;
  final String text;
  final double confidence;
  final Color textColor;

  SpeechState({
    required this.isInitialized,
    required this.isListening,
    required this.text,
    required this.confidence,
    required this.textColor,
  });

  SpeechState copyWith({
    bool? isInitialized,
    bool? isListening,
    String? text,
    double? confidence,
    Color? textColor,
  }) {
    return SpeechState(
      isInitialized: isInitialized ?? this.isInitialized,
      isListening: isListening ?? this.isListening,
      text: text ?? this.text,
      confidence: confidence ?? this.confidence,
      textColor: textColor ?? this.textColor,
    );
  }
}

class SpeechInitial extends SpeechState {
  SpeechInitial()
      : super(
          isInitialized: false,
          isListening: false,
          text: "",
          confidence: 1.0,
          textColor: Colors.black,
        );
}
