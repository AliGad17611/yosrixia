import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:yosrixia/core/responsive/widget_height.dart';
import 'package:yosrixia/core/responsive/widget_width.dart';
import 'package:yosrixia/core/utils/constants.dart';

class SpeakerWidget extends StatelessWidget {
  const SpeakerWidget({
    super.key,
    required this.voicePath,
  });
  final String voicePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final player = AudioPlayer();
        await player.play(AssetSource(voicePath));
      },
      child: Container(
        width: widgetWidth(context: context, width: 78),
        height: widgetHeight(context: context, height: 75),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(widgetWidth(context: context, width: 35))),
          color: kPrimaryColor,
        ),
        child: const Icon(
          Icons.volume_up,
          size: 40,
          color: kBlackColor,
        ),
      ),
    );
  }
}
