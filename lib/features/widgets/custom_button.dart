import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPressed, this.text = 'تسجيل دخول', this.width = 275, this.height = 65, this.textColor = kSecondaryColor});

  final void Function() onPressed;
  final String text;
  final double width;
  final double height;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: Styles.textStyle40.copyWith(color: textColor),
          )),
    );
  }
}
