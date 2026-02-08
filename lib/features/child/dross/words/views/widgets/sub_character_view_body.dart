import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/helper/global_variable.dart';
import 'package:yosrixia/core/helper/sub_characters_map.dart';
import 'package:yosrixia/core/models/character_model.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/dross/tutorial/cubit/tutorial_state.dart';
import 'package:yosrixia/features/child/dross/tutorial/sub_character_tutorial_cubit/sub_character_tutorial_cubit.dart';
import 'package:yosrixia/features/child/dross/tutorial/widgets/sub_character_tutorial_overlay.dart';
import 'package:yosrixia/features/child/dross/words/manger/speech_bloc/speech_bloc.dart';
import 'package:yosrixia/features/child/dross/words/views/widgets/character_widget.dart';
import 'package:yosrixia/features/child/dross/words/views/widgets/letter_to_word.dart';

class SubCharacterViewBody extends StatelessWidget {
  const SubCharacterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final String mainCharacter = globalMainCharacter;
    log('main character is $mainCharacter');

    return BlocProvider(
      create: (context) => SubCharacterTutorialCubit()..checkTutorialStatus(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => SpeechBloc()),
            ],
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 45, right: 38, left: 38),
                      child: Text(
                        mainCharacter,
                        style: Styles.textStyle96,
                      ),
                    ),
                    const SizedBox(height: 60),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 38),
                      child: Row(
                        children: [
                          CharacterWidget(
                            subLetter: subCharactersMap[mainCharacter]?[0] ??
                                CharacterModel(
                                    characterToDisplay: '',
                                    wordToCheck: '',
                                    voicePath: ''),
                          ),
                          const Spacer(),
                          CharacterWidget(
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
                          CharacterWidget(
                            subLetter: subCharactersMap[mainCharacter]?[2] ??
                                CharacterModel(
                                    characterToDisplay: '',
                                    wordToCheck: '',
                                    voicePath: ''),
                          ),
                          const Spacer(),
                          CharacterWidget(
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
                        LetterToWord(
                          letter: subCharactersMap[mainCharacter]?[0]
                                  .characterToDisplay ??
                              '',
                          index: 0,
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
                BlocBuilder<SubCharacterTutorialCubit, TutorialState>(
                  builder: (context, state) {
                    if (state is TutorialVisible) {
                      return SubCharacterTutorialOverlay(
                          index: state.currentIndex, isLast: state.isLastStep);
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
