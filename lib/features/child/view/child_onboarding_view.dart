import 'package:flutter/material.dart';
import 'package:yosrixia/features/child/view/widgets/child_onboarding_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class ChildOnboardingView extends StatelessWidget {
  const ChildOnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: ChildOnboardingViewBody(),);
  }
}
