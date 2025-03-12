import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/helper/onboarding_list.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/cubit/child_onboarding_cubit.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key, required this.index,});
  final int index;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (index == onboardingList.length - 1) {
          GoRouter.of(context).go(AppRouter.childHome);
        } else {
          context.read<ChildOnboardingCubit>().goToNextPage(index+1);
        }
      },
      child: Text(
        'التالي',
        style: Styles.textStyle32,
      ),
    );
  }
}
