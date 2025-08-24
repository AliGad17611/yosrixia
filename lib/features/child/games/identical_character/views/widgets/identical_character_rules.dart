import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class IdenticalCharacterRules extends StatelessWidget {
  const IdenticalCharacterRules({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "طريقة اللعب: ",
          style: Styles.textStyle24.copyWith(color: kPurpleColor),
        ),
        Text(
          "• سترى بطاقات مقلوبة أمامك.",
          style: Styles.textStyle24.copyWith(color: kBlackColor),
        ),
        Text(
          "• افتح بطاقتين لتبحث عن المتشابهتين.",
          style: Styles.textStyle24.copyWith(color: kBlackColor),
        ),
        Text(
          "• إن كانتا متشابهتين، ستبقيان مكشوفتين.",
          style: Styles.textStyle24.copyWith(color: kBlackColor),
        ),
        Text(
          "• إن كانتا غير متشابهتين، ستعودا إلى الوضع المقلوب.",
          style: Styles.textStyle24.copyWith(color: kBlackColor),
        ),
        Text(
          "• واصل اللعب حتى تكشف جميع البطاقات.",
          style: Styles.textStyle24.copyWith(color: kBlackColor),
        ),
      ],
    );
  }
}
