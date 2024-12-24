
import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/styles.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,  this.text='Next', required this.onPressed,
  });
  final String text ;

  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: Styles.textStyle32,
        ));
  }
}
