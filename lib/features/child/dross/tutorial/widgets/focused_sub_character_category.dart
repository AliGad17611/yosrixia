import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yosrixia/core/helper/global_variable.dart';
import 'package:yosrixia/core/helper/sub_characters_map.dart';
import 'package:yosrixia/core/models/character_model.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/dross/words/views/widgets/letter_to_word.dart';

class FocusedSubCharacterCategory extends StatelessWidget {
  final int index;
  const FocusedSubCharacterCategory({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final String mainCharacter = globalMainCharacter;
    final subLetter0 = subCharactersMap[mainCharacter]?[0] ??
        CharacterModel(characterToDisplay: '', wordToCheck: '', voicePath: '');

    return Directionality(
      textDirection: TextDirection.rtl,
      child: IgnorePointer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Dummy header for spacing
            Opacity(
              opacity: 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 45, right: 38, left: 38),
                child: Text(
                  mainCharacter,
                  style: Styles.textStyle96,
                ),
              ),
            ),
            const SizedBox(height: 60),

            // First Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38),
              child: Row(
                children: [
                  // Targeted CharacterWidget parts
                  _buildTargetedParts(subLetter0, index),
                  const Spacer(),
                  const _PlaceholderWidget(),
                ],
              ),
            ),
            const SizedBox(height: 21),

            // Second Row
            const Opacity(
              opacity: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Row(
                  children: [
                    _PlaceholderWidget(),
                    Spacer(),
                    _PlaceholderWidget(),
                  ],
                ),
              ),
            ),
            const Spacer(),

            // Bottom Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Opacity(
                  opacity: index == 2 ? 1 : 0,
                  child: LetterToWord(
                    letter: subCharactersMap[mainCharacter]?[0]
                            .characterToDisplay ??
                        '',
                    index: 0,
                  ),
                ),
                const Opacity(
                    opacity: 0, child: LetterToWord(letter: '', index: 1)),
                const Opacity(
                    opacity: 0, child: LetterToWord(letter: '', index: 2)),
                const Opacity(
                    opacity: 0, child: LetterToWord(letter: '', index: 3)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTargetedParts(CharacterModel subLetter, int tutorialIndex) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Index 0: GestureDetector part (The Box)
        Opacity(
          opacity: tutorialIndex == 0 ? 1 : 0,
          child: Container(
            width: 148.w,
            height: 167.h,
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
        // Index 1: IconButton part (The Mic)
        Opacity(
          opacity: tutorialIndex == 1 ? 1 : 0,
          child: const Icon(
            Icons.graphic_eq,
            size: 50,
            color: kSecondaryColor,
          ),
        ),
      ],
    );
  }
}

class _PlaceholderWidget extends StatelessWidget {
  const _PlaceholderWidget();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: 148.w, height: 167.h),
        const Icon(Icons.graphic_eq, size: 50, color: Colors.transparent),
      ],
    );
  }
}
