
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/responsive/widget_height.dart';
import 'package:yosrixia/core/responsive/widget_width.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/features/child/dross/words/manger/speech_bloc/speech_bloc.dart';
import 'package:yosrixia/features/child/dross/words/manger/speech_bloc/speech_events.dart';

class MicWidget extends StatelessWidget {
  const MicWidget( {
    super.key, required this.text,
  });
  final String text ;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SpeechBloc>();
    return GestureDetector(
      onTap: () {
        bloc.add(StartListeningEvent(wordToMatch: text));
      },
      child: Container(
        width: widgetWidth(context: context, width: 78),
        height: widgetHeight(context: context, height: 75),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(
              widgetWidth(context: context, width: 35))),
          color: kPrimaryColor,
        ),
        child:
            const Icon(Icons.mic, size: 40, color: kBlackColor),
      ),
    );
  }
}
