import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/features/child/games/puzzel/cubit/puzzel_cubit.dart';
import 'package:yosrixia/features/child/games/puzzel/cubit/puzzle_state.dart';

class DraggableImage extends StatelessWidget {
  const DraggableImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PuzzleCubit, PuzzleState>(
      builder: (context, state) {
        final cubit = context.read<PuzzleCubit>();

        if (state is PuzzleLoaded) {
          final remaining = state.shuffledImages
              .where((img) => !state.placedImages.values.contains(img))
              .toList();

          if (remaining.isEmpty) {
            return ElevatedButton(
              onPressed: cubit.loadNextLetter,
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text(
                "التالي",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kSecondaryColor,
                ),
              ),
            );
          }

          return Column(
            children: [
              Draggable<String>(
                data: remaining.first,
                feedback: Image.asset(
                  remaining.first,
                  width: 80,
                  height: 80,
                  opacity: const AlwaysStoppedAnimation(0.7),
                ),
                childWhenDragging: const SizedBox(width: 80, height: 80),
                child: Image.asset(remaining.first, width: 80, height: 80),
              ),
              const SizedBox(height: 20),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
