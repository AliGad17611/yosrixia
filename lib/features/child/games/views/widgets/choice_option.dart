import 'package:flutter/material.dart';
import 'package:yosrixia/core/responsive/widget_height.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class ChoiceOption extends StatelessWidget {
  const ChoiceOption({
    super.key,
    required this.text,
    required this.onTap,  this.backgroundColor =kPrimaryColor,
  });
  final String text;
  final Color backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: widgetHeight(context: context, height: 84),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: backgroundColor,
        ),
        child: Align(
            alignment: Alignment.center,
            child: Text(text,
                style: Styles.textStyle48.copyWith(color: kBlackColor))),
      ),
    );
  }
}
