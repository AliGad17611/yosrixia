import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/responsive/widget_height.dart';
import 'package:yosrixia/features/child/dross/gomal/models/gomal_model.dart';
import 'package:yosrixia/features/child/dross/words/manger/speech_bloc/speech_bloc.dart';
import 'package:yosrixia/features/child/dross/words/views/widgets/mic_widget.dart';
import 'package:yosrixia/features/child/dross/words/views/widgets/speaker_widget.dart';
import 'package:yosrixia/features/child/dross/words/views/widgets/text_widget.dart';

class SentenceWidget extends StatelessWidget {
  const SentenceWidget({super.key, required this.gomalModel});
  final GomalModel gomalModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpeechBloc(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12,
        children: [
          const Spacer(),
          Image.asset(
            gomalModel.imagePath,
            height: widgetHeight(context: context, height: 320),
            fit: BoxFit.cover,
          ),
          TextWidget(
            text: gomalModel.gomlaToDisplay,
          ),
          Row(
            children: [
              MicWidget(
                text: gomalModel.gomlaToCheck,
              ),
              const Spacer(),
              SpeakerWidget(
                voicePath: gomalModel.voicePath,
              )
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
