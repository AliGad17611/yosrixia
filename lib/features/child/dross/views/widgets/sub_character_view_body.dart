import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/dross/views/widgets/character_widget.dart';
import 'package:yosrixia/features/child/dross/views/widgets/letter_to_word.dart';

class SubCharacterViewBody extends StatelessWidget {
  const SubCharacterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 45, right: 38, left: 38),
              child: Text(
                'أ',
                style: Styles.textStyle96,
              ),
            ),
            const SizedBox(height: 60),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 38),
              child: Row(
                children: [
                  CharacterWidget(
                    subLetter: 'أَ',
                  ),
                  Spacer(),
                  CharacterWidget(
                    subLetter: 'إِ',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 21),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                children: [
                  CharacterWidget(
                    subLetter: 'أُ',
                  ),
                  Spacer(),
                  CharacterWidget(
                    subLetter: 'أْ',
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LetterToWord(letter: 'أَ'),
                LetterToWord(letter: 'إِ'),
                LetterToWord(letter: 'أُ'),
                LetterToWord(letter: 'أْ'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
