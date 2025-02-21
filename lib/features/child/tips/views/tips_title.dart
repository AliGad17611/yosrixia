import 'package:flutter/material.dart';
import 'package:yosrixia/core/responsive/widget_height.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class TipsTitle extends StatelessWidget {
  const TipsTitle({
    super.key,

  });


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widgetHeight(context: context, height: 84),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: kPrimaryColor,
      ),
      child: Align(
          alignment: Alignment.center,
          child: Text('نصائح وأنشطة إضافية',
              style: Styles.textStyle36Passion.copyWith(color: kBlackColor))),
    );
  }
}
