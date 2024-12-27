import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/helper/sub_characters_map.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/dross/manger/speech_bloc/speech_bloc.dart';
import 'package:yosrixia/features/child/dross/views/widgets/character_widget.dart';
import 'package:yosrixia/features/child/dross/views/widgets/letter_to_word.dart';

class SubCharacterViewBody extends StatelessWidget {
  const SubCharacterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: BlocProvider(
          create: (context) => SpeechBloc(),
          child: Column(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38),
                child: Row(
                  children: [
                    CharacterWidget(
                      subLetter: subCharactersMap['أ']![0],
                    ),
                    const Spacer(),
                    CharacterWidget(
                      subLetter: subCharactersMap['أ']![1],
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
                      subLetter: subCharactersMap['أ']![2],
                    ),
                    const Spacer(),
                    CharacterWidget(
                      subLetter: subCharactersMap['أ']![3],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LetterToWord(
                    letter: subCharactersMap['أ']![0].characterToDisplay,
                    index: 0,
                  ),
                  LetterToWord(
                    letter: subCharactersMap['أ']![1].characterToDisplay,
                    index: 1,
                  ),
                  LetterToWord(
                    letter: subCharactersMap['أ']![2].characterToDisplay,
                    index: 2,
                  ),
                  LetterToWord(
                    letter: subCharactersMap['أ']![3].characterToDisplay,
                    index: 3,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
