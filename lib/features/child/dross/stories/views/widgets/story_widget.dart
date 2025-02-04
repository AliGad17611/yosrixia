import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/features/child/dross/stories/models/story_model.dart';
import 'package:yosrixia/features/child/dross/stories/views/widgets/text_container.dart';
import 'package:yosrixia/features/child/dross/words/manger/speech_bloc/speech_bloc.dart';
import 'package:yosrixia/features/child/dross/words/views/widgets/mic_widget.dart';
import 'package:yosrixia/features/child/dross/words/views/widgets/speaker_widget.dart';

class StoryWidget extends StatelessWidget {
  const StoryWidget({
    super.key,
    required this.storyModel,
  });
  final StoryModel storyModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpeechBloc(),
      child: Column(
        spacing: 12,
        children: [
          TextContainer(
            text: storyModel.textToDisplay,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 24,
            children: [
              MicWidget(
                text: storyModel.textToCheck,
              ),
              SpeakerWidget(
                voicePath: storyModel.voicePath,
              )
            ],
          ),
          Expanded(
            child: (storyModel.imagePath.length > 1)
                ? LayoutBuilder(
                    builder: (context, constraints) {
                      double halfHeight = constraints.maxHeight / 2;
                      double halfWidth = constraints.maxWidth / 2;
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Image.asset(
                              storyModel.imagePath[0],
                              height: halfHeight,
                              width: halfWidth,
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 0,
                            child: Image.asset(
                              storyModel.imagePath[1],
                              height: halfHeight,
                              width: halfWidth,
                            ),
                          ),
                        ],
                      );
                    },
                  )
                : Image.asset(
                    storyModel.imagePath[0],
                  ),
          )
        ],
      ),
    );
  }
}
