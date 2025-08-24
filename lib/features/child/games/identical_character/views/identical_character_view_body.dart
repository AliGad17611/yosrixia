import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/features/child/games/identical_character/views/widgets/identical_character_card.dart';
import 'package:yosrixia/features/child/games/identical_character/cubits/identical_character_cubit.dart';
import 'package:yosrixia/features/child/games/identical_character/views/widgets/game_finished_dialog.dart';

class IdenticalCharacterViewBody extends StatelessWidget {
  const IdenticalCharacterViewBody({super.key});

  void _showGameFinishedDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => GameFinishedDialog(
        onPlayAgain: () {
          Navigator.of(dialogContext).pop();
          context.read<IdenticalCharacterCubit>().restartGame();
        },
        onGoBack: () {
          Navigator.of(dialogContext).pop();
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IdenticalCharacterCubit()..initializeGame(),
      child: SafeArea(
        child: Scaffold(
          body: BlocListener<IdenticalCharacterCubit, IdenticalCharacterState>(
            listener: (context, state) {
              if (state is IdenticalCharacterGameState &&
                  state.isGameFinished) {
                // Add a small delay before showing the dialog to let the last animation complete
                Future.delayed(const Duration(milliseconds: 500), () {
                  if (context.mounted) {
                    _showGameFinishedDialog(context);
                  }
                });
              }
            },
            child:
                BlocBuilder<IdenticalCharacterCubit, IdenticalCharacterState>(
              builder: (context, state) {
                if (state is IdenticalCharacterGameState) {
                  return Center(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 25,
                        mainAxisSpacing: 25,
                        childAspectRatio: 0.7,
                      ),
                      shrinkWrap: true,
                      itemCount: state.characters.length,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      itemBuilder: (context, index) {
                        return IdenticalCharacterCard(
                          character: state.characters[index],
                          isFlipped: state.flippedCards[index],
                          isMatched: state.matchedCards[index],
                          onTap: () {
                            context
                                .read<IdenticalCharacterCubit>()
                                .flipCard(index);
                          },
                        );
                      },
                    ),
                  );
                }

                // Loading state or initial state
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
