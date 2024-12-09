
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/utils/styles.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key, required this.nextRoute, this.text='Next', this.extra,
  });
  final String nextRoute;
  final String text ;
  final String? extra;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          GoRouter.of(context).push(nextRoute);
        },
        child: Text(
          text,
          style: Styles.textStyle32,
        ));
  }
}
