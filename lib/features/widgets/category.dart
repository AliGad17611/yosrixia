import 'package:flutter/material.dart';
import 'package:yosrixia/core/responsive/widget_height.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class Category extends StatelessWidget {
  const Category({
    super.key,
    required this.text,
    required this.onTap,
  });
  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: widgetHeight(context: context, height: 93),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: kPrimaryColor,
        ),
        child: Align(
            alignment: Alignment.center,
            child: Text(text, style: Styles.textStyle48)),
      ),
    );
  }
}
