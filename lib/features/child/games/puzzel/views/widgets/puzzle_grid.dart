import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/helper/puzzel_completed_map.dart';
import 'package:yosrixia/features/child/games/puzzel/cubit/puzzel_cubit.dart';
import 'package:yosrixia/features/child/games/puzzel/cubit/puzzle_state.dart';

class PuzzleGrid extends StatelessWidget {
  const PuzzleGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PuzzleCubit, PuzzleState>(
      builder: (context, state) {
        if (state is PuzzleLoaded) {
          final remaining = state.shuffledImages
              .where((img) => !state.placedImages.values.contains(img))
              .toList();
          final String currentLetter = state.letter;

          if (remaining.isEmpty) {
            return Column(children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(30),
                  itemCount: 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        color: Colors.grey[300],
                      ),
                      child: Image.asset(puzzelCompletedMap[currentLetter]!,
                          fit: BoxFit.cover),
                    );
                  },
                ),
              ),
            ]);
          }

          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(30),
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    final placed = state.placedImages[index];
                    return DragTarget<String>(
                      onAcceptWithDetails: (details) {
                        log("onAcceptWithDetails: ${details.data}");
                        context
                            .read<PuzzleCubit>()
                            .placeImage(index, details.data);
                      },
                      builder: (context, candidateData, rejectedData) {
                        return LayoutBuilder(
                          builder: (context, constraints) {
                            return Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 2),
                                color: Colors.grey[300],
                              ),
                              child: placed != null
                                  ? Image.asset(placed, fit: BoxFit.cover)
                                  : const Center(child: Text("Drop Here")),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is PuzzleCompleted) {
          return const Center(
            child: Text(
              "أحسنت! خلصت كل الحروف",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          );
        } else {
          return const Center(
            child: Text(
              "Loading...",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          );
        }
      },
    );
  }
}
