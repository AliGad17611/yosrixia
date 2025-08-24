import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/features/child/games/identical_character/cubits/tutorial_cubit/identical_character_tutorial_cubit.dart';
import 'package:yosrixia/features/child/games/identical_character/cubits/tutorial_cubit/identical_character_tutorial_state.dart';
import 'package:yosrixia/features/child/games/identical_character/views/identical_character_tutorial_view_body.dart';
import 'package:yosrixia/features/child/games/identical_character/views/identical_character_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class IdenticalCharacterView extends StatelessWidget {
  const IdenticalCharacterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BackGround(
      child: BlocProvider(
        create: (context) =>
            IdenticalCharacterTutorialCubit()..checkTutorialStatus(),
        child: BlocBuilder<IdenticalCharacterTutorialCubit,
            IdenticalCharacterTutorialState>(
          builder: (context, state) {
            if (state is IdenticalCharacterTutorialSeen) {
              return const IdenticalCharacterViewBody();
            } else if (state is IdenticalCharacterTutorialNotSeen) {
              return const IdenticalCharacterTutorialViewBody();
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
