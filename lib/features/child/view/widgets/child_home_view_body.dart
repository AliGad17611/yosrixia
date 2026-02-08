import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/features/child/home_tutorial/cubit/child_home_tutorial_cubit.dart';
import 'package:yosrixia/features/child/home_tutorial/widgets/child_home_tutorial_overlay.dart';
import 'package:yosrixia/features/child/view/widgets/body_content.dart';
import 'package:yosrixia/features/child/dross/tutorial/cubit/tutorial_state.dart';

class ChildHomeViewBody extends StatelessWidget {
  const ChildHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChildHomeTutorialCubit()..checkTutorialStatus(),
      child: Scaffold(
        body: Stack(
          children: [
            // Main content
            const BodyContent(),
            // Tutorial overlay
            BlocBuilder<ChildHomeTutorialCubit, TutorialState>(
              builder: (context, state) {
                if (state is TutorialVisible) {
                  return const ChildHomeTutorialOverlay();
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}

// End of ChildHomeViewBody
