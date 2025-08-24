import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/games/identical_character/cubits/tutorial_cubit/identical_character_tutorial_cubit.dart';
import 'package:yosrixia/features/child/games/identical_character/views/widgets/identical_character_goal.dart';
import 'package:yosrixia/features/child/games/identical_character/views/widgets/identical_character_rules.dart';
import 'package:yosrixia/features/child/games/identical_character/views/widgets/text_container.dart';

class IdenticalCharacterTutorialViewBody extends StatelessWidget {
  const IdenticalCharacterTutorialViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'تطابق البطاقات',
                  style: Styles.textStyle48.copyWith(color: kPrimaryColor),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    const TextContainer(child: IdenticalCharacterGoal()),
                    const SizedBox(height: 20),
                    const TextContainer(child: IdenticalCharacterRules()),
                    const SizedBox(height: 35),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<IdenticalCharacterTutorialCubit>()
                            .markTutorialAsSeen();
                      },
                      child: Text(
                        "لتبدأ المغامرة",
                        style: Styles.textStyle24.copyWith(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
