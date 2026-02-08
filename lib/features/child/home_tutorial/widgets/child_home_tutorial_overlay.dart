import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/features/child/dross/tutorial/cubit/tutorial_state.dart';
import 'package:yosrixia/features/child/home_tutorial/cubit/child_home_tutorial_cubit.dart';
import 'package:yosrixia/features/child/view/widgets/arrow.dart';
import 'package:yosrixia/features/child/view/widgets/description.dart';
import 'package:yosrixia/features/child/view/widgets/focused_category.dart';
import 'package:yosrixia/features/child/view/widgets/overlay_scaffold.dart';
import 'package:yosrixia/features/child/view/widgets/tutorial_next_button.dart';

class ChildHomeTutorialOverlay extends StatelessWidget {
  const ChildHomeTutorialOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildHomeTutorialCubit, TutorialState>(
      builder: (context, state) {
        if (state is TutorialVisible) {
          return Stack(
            children: [
              const OverlayScaffold(),
              FocusedCategory(index: state.currentIndex),
              Arrow(index: state.currentIndex),
              Description(index: state.currentIndex),
              TutorialNextButton(
                onPressed: () {
                  context.read<ChildHomeTutorialCubit>().nextStep();
                },
                isLast: state.isLastStep,
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
