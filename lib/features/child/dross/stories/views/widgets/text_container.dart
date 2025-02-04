import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/dross/words/manger/speech_bloc/speech_bloc.dart';
import 'package:yosrixia/features/child/dross/words/manger/speech_bloc/speech_states.dart';

class TextContainer extends StatelessWidget {
  const TextContainer({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpeechBloc, SpeechState>(
      builder: (context, state) {
        Color containerColor = kPrimaryColor;

        if (state is MatchSpeechState) {
          containerColor = state.isMatch ? Colors.green : Colors.red;
        }
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: containerColor,
            ),
            child: Text(
              text,
              style: Styles.textStyle36Passion,
            ),
          ),
        );
      },
    );
  }
}
