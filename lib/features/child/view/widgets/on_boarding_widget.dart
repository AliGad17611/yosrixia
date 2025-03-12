import 'package:flutter/material.dart';
import 'package:yosrixia/core/helper/onboarding_list.dart';
import 'package:yosrixia/features/child/view/widgets/next_button.dart';
import 'package:yosrixia/features/child/view/widgets/onboarding_text_container.dart';

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const Spacer(
              flex: 2,
            ),
            OnboardingTextContainer(
              text: onboardingList[index].text,
            ),
            const Spacer(
              flex: 1,
            ),
            Image.asset(
              onboardingList[index].imagePath,
              width: double.infinity,
            ),
            const Spacer(
              flex: 1,
            ),
             NextButton(index: index,),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
