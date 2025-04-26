import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/helper/puzzel_map.dart';
import 'package:yosrixia/features/child/games/puzzel/cubit/puzzel_cubit.dart';
import 'package:yosrixia/features/child/games/puzzel/views/widgets/draggable_image.dart';
import 'package:yosrixia/features/child/games/puzzel/views/widgets/puzzle_grid.dart';

class PuzzelViewBody extends StatelessWidget {
  const PuzzelViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => PuzzleCubit(puzzelMap)..loadNextLetter(),
          child: const Column(
            children: [
              Expanded(
                child: PuzzleGrid(),
              ),
              DraggableImage(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
