import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class StartButton extends StatelessWidget {
  const StartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).go(
          AppRouter.login,
        );
      },
      child: Container(
          width: 275,
          height: 65,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(33)),
              gradient: LinearGradient(
                begin: AlignmentDirectional.centerStart,
                end: AlignmentDirectional.centerEnd,
                colors: [
                  kGridentBegin,
                  kGridentEnd,
                ],
              )),
          child: const Center(child: Text('Start', style: Styles.textStyle40))),
    );
  }
}
