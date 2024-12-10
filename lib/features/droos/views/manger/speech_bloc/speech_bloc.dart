import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:yosrixia/features/droos/views/manger/speech_bloc/speech_events.dart';
import 'package:yosrixia/features/droos/views/manger/speech_bloc/speech_states.dart';

class SpeechBloc extends Bloc<SpeechEvent, SpeechState> {
  final stt.SpeechToText _speechToText = stt.SpeechToText();

  SpeechBloc() : super(SpeechInitial()) {
    on<InitializeSpeech>(_onInitializeSpeech);
    on<StartListening>(_onStartListening);
    on<StopListening>(_onStopListening);
    on<UpdateSpeechResult>(_onUpdateSpeechResult);
    on<CheckMatch>(_onCheckMatch);
  }

  void _onInitializeSpeech(InitializeSpeech event, Emitter<SpeechState> emit) async {
    bool available = await _speechToText.initialize();
    emit(state.copyWith(isInitialized: available));
  }

  void _onStartListening(StartListening event, Emitter<SpeechState> emit) async {
    if (!state.isInitialized) return;

    _speechToText.listen(
      onResult: (result) {
        add(UpdateSpeechResult(result.recognizedWords, result.confidence));
      },
      localeId: 'ar-EG', // العربية
    );

    emit(state.copyWith(isListening: true));
  }

  void _onStopListening(StopListening event, Emitter<SpeechState> emit) async {
    await _speechToText.stop();
    emit(state.copyWith(isListening: false));
  }

  void _onUpdateSpeechResult(UpdateSpeechResult event, Emitter<SpeechState> emit) {
    emit(state.copyWith(text: event.text, confidence: event.confidence));
  }

  void _onCheckMatch(CheckMatch event, Emitter<SpeechState> emit) {
    Color newColor;
    if (state.text == event.customText) {
      newColor = Colors.green;
    } else {
      newColor = Colors.red;
    }

    emit(state.copyWith(textColor: newColor));
  }
}
