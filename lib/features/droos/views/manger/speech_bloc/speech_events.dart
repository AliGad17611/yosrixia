abstract class SpeechEvent {}

class InitializeSpeech extends SpeechEvent {}

class StartListening extends SpeechEvent {}

class StopListening extends SpeechEvent {}

class UpdateSpeechResult extends SpeechEvent {
  final String text;
  final double confidence;

  UpdateSpeechResult(this.text, this.confidence);
}

class CheckMatch extends SpeechEvent {
  final String customText;

  CheckMatch(this.customText);
}
