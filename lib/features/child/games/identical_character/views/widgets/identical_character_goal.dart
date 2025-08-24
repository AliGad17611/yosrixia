import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class IdenticalCharacterGoal extends StatelessWidget {
  const IdenticalCharacterGoal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "الهدف: ",
          style: Styles.textStyle24.copyWith(color: kPurpleColor),
        ),
        Text(
          "تطوير مهارات الطفل في التعرف على الحروف العربية وتقوية الذاكرة البصرية.",
          style: Styles.textStyle24.copyWith(color: kBlackColor),
        ),
      ],
    );
  }
}
