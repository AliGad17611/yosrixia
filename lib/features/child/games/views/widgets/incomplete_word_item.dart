import 'package:flutter/material.dart';
import 'package:yosrixia/core/responsive/widget_height.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class IncompleteWordItem extends StatelessWidget {
  const IncompleteWordItem({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widgetHeight(context: context, height: 93),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: kPrimaryColor,
      ),
      child: Align(
          alignment: Alignment.center,
          child: Text(text,
              style: Styles.textStyle48.copyWith(color: kBlackColor))),
    );
  }
}
