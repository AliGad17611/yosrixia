import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/models/word_model.dart';
import 'package:yosrixia/features/child/dross/words/manger/speech_bloc/speech_bloc.dart';
import 'package:yosrixia/features/child/dross/words/views/widgets/mic_widget.dart';
import 'package:yosrixia/features/child/dross/words/views/widgets/speaker_widget.dart';
import 'package:yosrixia/features/child/dross/words/views/widgets/text_widget.dart';

class WordWidget extends StatelessWidget {
  const WordWidget({
    super.key,
    required this.wordModel,
  });
  final WordModel wordModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpeechBloc(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(left: wordModel.imagePadding),
              child: Image.asset(
                wordModel.imagePath,
              ),
            ),
            Row(
              children: [
                MicWidget(
                  text: wordModel.wordToCheck,
                ),
                const Spacer(),
                TextWidget(
                  text: wordModel.wordToDisplay,
                ),
                const Spacer(),
                SpeakerWidget(
                  voicePath: wordModel.voicePath,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
