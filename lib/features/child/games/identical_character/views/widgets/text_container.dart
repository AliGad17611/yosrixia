import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/constants.dart';

class TextContainer extends StatelessWidget {
  const TextContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: kPrimaryColor,
      ),
      child: child,
    );
  }
}
