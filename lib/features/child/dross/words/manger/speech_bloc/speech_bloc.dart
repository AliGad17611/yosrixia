import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:yosrixia/features/child/dross/words/manger/speech_bloc/speech_events.dart';
import 'package:yosrixia/features/child/dross/words/manger/speech_bloc/speech_states.dart';

class SpeechBloc extends Bloc<SpeechEvent, SpeechState> {
  final stt.SpeechToText _speechToText;
  final player = AudioPlayer();

  SpeechBloc()
      : _speechToText = stt.SpeechToText(),
        super(InitialSpeechState()) {
    on<StartListeningEvent>(_onStartListening);
    on<StopListeningEvent>(_onStopListening);
    on<ListeningSpeechEvent>(_onListeningSpeech);
  }

  Future<void> _onStartListening(
      StartListeningEvent event, Emitter<SpeechState> emit) async {
    if (await _speechToText.initialize()) {
      _speechToText.listen(
        onResult: (result) {
          final text = result.recognizedWords;
          if (result.finalResult) {
            add(ListeningSpeechEvent(
                recognizedText: text, wordToMatch: event.wordToMatch));
          }
        },
        localeId: 'ar-EG',
      );
    }
  }

  Future<void> _onStopListening(
      StopListeningEvent event, Emitter<SpeechState> emit) async {
    await _speechToText.stop();
    emit(InitialSpeechState());
  }

  void _onListeningSpeech(
      ListeningSpeechEvent event, Emitter<SpeechState> emit) async {
    log(event.recognizedText);
    log(event.wordToMatch);
    if (event.recognizedText == event.wordToMatch) {
      await player.play(AssetSource('media/sound/correct.wav'));
      emit(MatchSpeechState(true));
    } else {
      await player.play(AssetSource('media/sound/wrong.wav'));
      emit(MatchSpeechState(false));
    }
  }
}
