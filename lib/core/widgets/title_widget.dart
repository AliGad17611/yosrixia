import 'package:flutter/material.dart';
import 'package:yosrixia/core/responsive/widget_height.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.title,
  });
  final String title;


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
          child: Text(title,
              style: Styles.textStyle36Passion.copyWith(color: kBlackColor))),
    );
  }
}
