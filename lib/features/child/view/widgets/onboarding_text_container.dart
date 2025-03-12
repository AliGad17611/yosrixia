import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class OnboardingTextContainer extends StatelessWidget {
  const OnboardingTextContainer({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.all(8),
        // width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: kPrimaryColor,
        ),
        child: Text(
          text,
          style: Styles.textStyle36Passion,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
