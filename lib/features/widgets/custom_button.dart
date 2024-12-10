import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 275,
      height: 65,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
          ),
          onPressed: () {
            GoRouter.of(context).push(AppRouter.aleph1);
          },
          child: Text(
            'Login',
            style: Styles.textStyle40.copyWith(color: kSecondaryColor),
          )),
    );
  }
}
