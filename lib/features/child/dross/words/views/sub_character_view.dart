import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:yosrixia/features/child/dross/sub_character_tutorial/cubit/sub_character_tutorial_cubit.dart';
import 'package:yosrixia/features/child/dross/sub_character_tutorial/widgets/sub_character_tutorial_view_body.dart';
import 'package:yosrixia/features/child/dross/tutorial/cubit/tutorial_state.dart';
import 'package:yosrixia/features/child/dross/words/views/widgets/sub_character_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class SubCharacterView extends StatelessWidget {
  const SubCharacterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BackGround(
      child: BlocProvider(
        create: (context) => SubCharacterTutorialCubit(),
        child: BlocBuilder<SubCharacterTutorialCubit, TutorialState>(
          builder: (context, state) {
            if (state is TutorialCompleted) {
              return const SubCharacterViewBody();
            }
            // Wrap tutorial view with ShowCaseWidget
            return ShowCaseWidget(
              builder: (context) => const SubCharacterTutorialViewBody(),
              onComplete: (index, key) {
                log('index is $index');
                log('key is $key');
                if (index == 3) {
                  context.read<SubCharacterTutorialCubit>().completeTutorial();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
