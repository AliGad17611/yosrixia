import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/games/helper/games_words_list.dart';
import 'package:yosrixia/features/child/games/manger/cubit/game_state.dart';
import 'package:yosrixia/features/child/games/manger/cubit/image_name_cubit.dart';
import 'package:yosrixia/features/child/games/views/widgets/choice_option.dart';

class ImageNameViewBody extends StatelessWidget {
  const ImageNameViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageNameCubit(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 35, right: 24, left: 24),
          child: BlocBuilder<ImageNameCubit, GameState>(
            builder: (context, state) {
              // Access the cubit instance
              final cubit = context.read<ImageNameCubit>();
              // Get the current question index
              final currentIndex = cubit.index;
              // Get the current question
              final currentQuestion = gamesWordsList[currentIndex];

              if (state is FinalScoreState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 12,
                  children: [
                    const Spacer(flex: 3),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Your score is',
                        style: Styles.textStyle40,
                      ),
                    ),
                    Text(
                      '${state.score} / ${gamesWordsList.length}',
                      style: Styles.textStyle40,
                    ),
                    const Spacer(flex: 5),
                  ],
                );
              } else {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 12,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: (currentIndex == 0) ? 70 : 0),
                        child: Image.asset(
                          currentQuestion.imagePath,
                          height: 320,
                          scale: 0.8,
                        ),
                      ),
                      const Spacer(flex: 2),
                      ...List.generate(
                        currentQuestion.choices.length,
                        (index) {
                          // Determine the background color based on the state
                          Color backgroundColor;
                          if (state is CorrectAnswerState &&
                              state.selectedIndex == index) {
                            backgroundColor = Colors.green;
                          } else if (state is WrongAnswerState &&
                              state.selectedIndex == index) {
                            backgroundColor = Colors.red;
                          } else if (state is WrongAnswerState &&
                              state.correctAnswerIndex == index) {
                            backgroundColor = Colors.green;
                          } else {
                            backgroundColor = kPrimaryColor;
                          }

                          return ChoiceOption(
                            onTap: () {
                              cubit.selectOption(index);
                            },
                            text: currentQuestion.choices[index],
                            backgroundColor: backgroundColor,
                          );
                        },
                      ),
                      const Spacer(flex: 5),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
