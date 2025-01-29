import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/dross/words/manger/speech_bloc/speech_bloc.dart';
import 'package:yosrixia/features/child/dross/words/manger/speech_bloc/speech_states.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key, required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpeechBloc, SpeechState>(
      builder: (context, state) {
        Color textColor = kPrimaryColor;

        if (state is MatchSpeechState) {
          textColor = state.isMatch ? Colors.green : Colors.red;
        }
        return Text(
          text,
          style: Styles.textStyle64Passion.copyWith(color: textColor),
        );
      },
    );
  }
}
