import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/games/helper/word_completion_list.dart';
import 'package:yosrixia/features/child/games/manger/cubit/game_state.dart';
import 'package:yosrixia/features/child/games/manger/cubit/word_completion_cubit.dart';
import 'package:yosrixia/features/child/games/views/widgets/choice_option.dart';
import 'package:yosrixia/features/child/games/views/widgets/incomplete_word_item.dart';
import 'package:yosrixia/features/widgets/category.dart';

class WordCompletionViewBody extends StatelessWidget {
  const WordCompletionViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WordCompletionCubit(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 35, right: 24, left: 24),
          child: BlocBuilder<WordCompletionCubit, GameState>(
            builder: (context, state) {
              // Access the cubit instance
              final cubit = context.read<WordCompletionCubit>();
              // Get the current question index
              final currentIndex = cubit.index;
              // Get the current question
              final currentQuestion = wordList[currentIndex];

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
                      '${state.score} / ${wordList.length}',
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
                      const Spacer(flex: 5),
                      IncompleteWordItem(
                        text: currentQuestion.incompleteWord,
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
