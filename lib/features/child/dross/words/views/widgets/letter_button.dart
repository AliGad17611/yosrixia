import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/helper/arabic_characters_map.dart';
import 'package:yosrixia/core/helper/global_variable.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class LetterButton extends StatelessWidget {
  const LetterButton({super.key, required this.letter});
  final String letter;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        globalMainCharacter = letter;
        globalSubCharacter = arabicCharactersMap[globalMainCharacter]!.keys.toList();
        // context.read<CharacterCubit>().updateMainCharacter(letter);
        log(globalMainCharacter);
        letter == ''
            ? null
            : GoRouter.of(context).push(AppRouter.subCharacters);
      },
      child: Container(
        width: 97,
        height: 97,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: letter == '' ? Colors.transparent : kPrimaryColor,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Text(
          letter,
          style: Styles.textStyle64Inter,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

