import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yosrixia/features/child/dross/tutorial/sub_character_tutorial_cubit/sub_character_tutorial_cubit.dart';
import 'package:yosrixia/features/child/dross/tutorial/widgets/focused_sub_character_category.dart';
import 'package:yosrixia/features/child/dross/tutorial/widgets/sub_character_arrow.dart';
import 'package:yosrixia/features/child/dross/tutorial/widgets/sub_character_description.dart';
import 'package:yosrixia/features/child/view/widgets/overlay_scaffold.dart';
import 'package:yosrixia/features/child/view/widgets/tutorial_next_button.dart';

class SubCharacterTutorialOverlay extends StatelessWidget {
  final int index;
  final bool isLast;
  const SubCharacterTutorialOverlay({
    super.key,
    required this.index,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const OverlayScaffold(),
        FocusedSubCharacterCategory(index: index),
        SubCharacterArrow(index: index),
        SubCharacterDescription(index: index),
        TutorialNextButton(
          onPressed: () {
            context.read<SubCharacterTutorialCubit>().nextStep();
          },
          isLast: isLast,
          left: 40.w, // Move to left as requested
        ),
      ],
    );
  }
}
