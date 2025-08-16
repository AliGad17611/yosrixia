import 'package:flutter/material.dart';
import 'package:yosrixia/core/models/character_model.dart';
import 'package:yosrixia/core/responsive/widget_height.dart';
import 'package:yosrixia/core/responsive/widget_width.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/dross/sub_character_tutorial/widgets/mic_i_con.dart';

class CharacterTutorialWidget extends StatelessWidget {
  const CharacterTutorialWidget({super.key, required this.subLetter});
  final CharacterModel subLetter;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
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
          const MicICon(),
      ],
    );
  }
}
