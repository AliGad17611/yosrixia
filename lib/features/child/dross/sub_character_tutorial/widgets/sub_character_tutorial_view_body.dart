
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:yosrixia/core/helper/global_variable.dart';
import 'package:yosrixia/core/helper/sub_characters_map.dart';
import 'package:yosrixia/core/models/character_model.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/dross/sub_character_tutorial/widgets/character_tutorial_widget.dart';
import 'package:yosrixia/features/child/dross/sub_character_tutorial/widgets/showcase_character_taturial.dart';
import 'package:yosrixia/features/child/dross/words/views/widgets/letter_to_word.dart';

class SubCharacterTutorialViewBody extends StatefulWidget {
  const SubCharacterTutorialViewBody({super.key});

  @override
  State<SubCharacterTutorialViewBody> createState() =>
      _SubCharacterTutorialViewBodyState();
}

class _SubCharacterTutorialViewBodyState
    extends State<SubCharacterTutorialViewBody> {
  final String mainCharacter = globalMainCharacter;
  final GlobalKey titleCharacterKey = GlobalKey();
  final GlobalKey characterSoundKey = GlobalKey();
  final GlobalKey characterMicKey = GlobalKey();
  final GlobalKey navigateCharacterKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        ShowCaseWidget.of(context).startShowCase([
          titleCharacterKey,
          characterSoundKey,
          characterMicKey,
          navigateCharacterKey
        ]));
    
  }

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
              child: Showcase(
                key: titleCharacterKey,
                title: 'حرف $mainCharacter',
                description: 'هذا الحرف الذي سنتعلمه الآن',
                child: Text(
                  mainCharacter,
                  style: Styles.textStyle96,
                ),
              ),
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38),
              child: Row(
                children: [
                  ShowcaseCharacterTutorial(
                    subLetter: subCharactersMap[mainCharacter]?[0] ??
                        CharacterModel(
                            characterToDisplay: '',
                            wordToCheck: '',
                            voicePath: ''),
                    characterSoundKey: characterSoundKey,
                    characterMicKey: characterMicKey,
                  ),
                  const Spacer(),
                  CharacterTutorialWidget(
                    subLetter: subCharactersMap[mainCharacter]?[1] ??
                        CharacterModel(
                            characterToDisplay: '',
                            wordToCheck: '',
                            voicePath: ''),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 21),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                children: [
                  CharacterTutorialWidget(
                    subLetter: subCharactersMap[mainCharacter]?[2] ??
                        CharacterModel(
                            characterToDisplay: '',
                            wordToCheck: '',
                            voicePath: ''),
                  ),
                  const Spacer(),
                  CharacterTutorialWidget(
                    subLetter: subCharactersMap[mainCharacter]?[3] ??
                        CharacterModel(
                            characterToDisplay: '',
                            wordToCheck: '',
                            voicePath: ''),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Showcase(
                  key: navigateCharacterKey,
                  title: 'التنقل',
                  description: 'اضغط هنا لتنتقل للكلمات التي تحتوي على الحرف',
                  child: LetterToWord(
                    letter: subCharactersMap[mainCharacter]?[0]
                            .characterToDisplay ??
                        '',
                    index: 0,
                  ),
                ),
                LetterToWord(
                  letter: subCharactersMap[mainCharacter]?[1]
                          .characterToDisplay ??
                      '',
                  index: 1,
                ),
                LetterToWord(
                  letter: subCharactersMap[mainCharacter]?[2]
                          .characterToDisplay ??
                      '',
                  index: 2,
                ),
                LetterToWord(
                  letter: subCharactersMap[mainCharacter]?[3]
                          .characterToDisplay ??
                      '',
                  index: 3,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
