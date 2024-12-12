import 'package:equatable/equatable.dart';

abstract class SpeechEvent extends Equatable {
  const SpeechEvent();

  @override
  List<Object?> get props => [];
}

// Event to start listening
class StartListeningEvent extends SpeechEvent {
  final String wordToMatch;

  const StartListeningEvent({required this.wordToMatch});
}

// Event to stop listening
class StopListeningEvent extends SpeechEvent {

}

// Event when text is recognized from speech
class ListeningSpeechEvent extends SpeechEvent {
  final String recognizedText;
   final String wordToMatch;

  const ListeningSpeechEvent({required this.recognizedText,required this.wordToMatch});

  @override
  List<Object?> get props => [recognizedText,wordToMatch];
}
