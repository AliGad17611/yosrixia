// speech_state.dart
abstract class SpeechState {}

class InitialSpeechState extends SpeechState {}

class ListeningSpeechState extends SpeechState {
  final String recognizedText;
  ListeningSpeechState(this.recognizedText);
}

class MatchSpeechState extends SpeechState {
  final bool isMatch;
  MatchSpeechState(this.isMatch);
}
