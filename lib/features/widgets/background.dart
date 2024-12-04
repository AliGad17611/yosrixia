import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/constants.dart';

class BackGround extends StatelessWidget {
  const BackGround({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            kGridentBegin,
            kGridentEnd,
          ])),
      child: child,
    );
  }
}
