import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/features/droos/views/manger/speech_bloc/speech_bloc.dart';
import 'package:yosrixia/features/droos/views/widgets/mic_widget.dart';
import 'package:yosrixia/features/droos/views/widgets/speaker_widget.dart';
import 'package:yosrixia/features/droos/views/widgets/text_widget.dart';

class WordWidget extends StatelessWidget {
  const WordWidget({
    super.key, required this.wordToMatch, required this.wordToDisplay, required this.imagePath,
  });
  final String wordToMatch;
  final String wordToDisplay;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpeechBloc(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Image.asset(
              imagePath,
            ),
          ),
            Row(
            children: [
              MicWidget(text: wordToMatch,),
              const Spacer(),
              TextWidget(text: wordToDisplay,),
              const Spacer(),
              const SpeakerWidget()
            ],
          ),
        ],
      ),
    );
  }
}
