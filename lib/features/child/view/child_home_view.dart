import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/features/child/dross/tutorial/cubit/tutorial_state.dart';
import 'package:yosrixia/features/child/home_tutorial/cubit/child_home_tutorial_cubit.dart';
import 'package:yosrixia/features/child/home_tutorial/widgets/child_home_tutorial_overlay.dart';
import 'package:yosrixia/features/child/view/widgets/child_home_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class ChildHomeView extends StatelessWidget {
  const ChildHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BackGround(
        child: BlocProvider(
      create: (context) => ChildHomeTutorialCubit()..checkTutorialStatus(),
      child: BlocBuilder<ChildHomeTutorialCubit, TutorialState>(
        builder: (context, state) {
          if (state is TutorialVisible) {
            return const ChildHomeTutorialOverlay();
          }
          return const ChildHomeViewBody();
        },
      ),
    ));
  }
}
