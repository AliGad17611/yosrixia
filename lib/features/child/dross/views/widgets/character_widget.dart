import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/models/character_model.dart';
import 'package:yosrixia/core/responsive/widget_height.dart';
import 'package:yosrixia/core/responsive/widget_width.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/dross/manger/speech_bloc/speech_bloc.dart';
import 'package:yosrixia/features/child/dross/manger/speech_bloc/speech_events.dart';

class CharacterWidget extends StatelessWidget {
  const CharacterWidget({super.key, required this.subLetter});
  final CharacterModel subLetter;

  @override
  Widget build(BuildContext context) {
        final bloc = context.read<SpeechBloc>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () async{
            final player = AudioPlayer();
        await player.play(AssetSource(subLetter.voicePath));
          },
          child: Container(
            width: widgetWidth(context: context, width: 148),
            height: widgetHeight(context: context, height: 167),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(35),
            ),
            child: Text(
              subLetter.characterToDisplay,
              style: Styles.textStyle64Inter,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        IconButton(
            onPressed: () {
        bloc.add(StartListeningEvent(wordToMatch: subLetter.wordToCheck));

            },
            icon:
                const Icon(Icons.graphic_eq, size: 50, color: kSecondaryColor)),
      ],
    );
  }
}
