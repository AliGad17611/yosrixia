import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yosrixia/core/utils/assets_data.dart';

class SubCharacterArrow extends StatelessWidget {
  final int index;
  const SubCharacterArrow({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    if (index == 2) {
      // Step 2 is focused on LetterToWord(index: 0) in the bottom row
      return Positioned(
        bottom: 55.h + 20.h, // LetterToWord height is 85.h
        right: MediaQuery.of(context).size.width / 8,
        child: Transform.rotate(
          angle: 45 * (3.14 / 180), // Pointing down
          child: Image.asset(
            AssetsData.childOnboardingPage6,
            width: 150.w,
          ),
        ),
      );
    }

    String asset = AssetsData.childOnboardingPage6;

    double? top;
    double? bottom;
    double? left;
    double? right;
    double rotation = 0;

    switch (index) {
      case 0: // Sound box (Top right in RTL row 1)
        top = 220.h;
        right = 160.w;
        break;
      case 1: // Mic icon (Below sound box)
        top = 370.h;
        right = 160.w;
        break;
    }

    Widget arrowImage = Image.asset(
      asset,
      width: 150.w,
    );

    if (rotation != 0) {
      arrowImage = Transform.rotate(
        angle: rotation,
        child: arrowImage,
      );
    }

    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: arrowImage,
    );
  }
}
