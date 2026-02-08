import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yosrixia/core/utils/assets_data.dart';

class Arrow extends StatelessWidget {
  final int index;
  const Arrow({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    String asset = (index == 0 || index == 2)
        ? AssetsData.childOnboardingPage7
        : AssetsData.childOnboardingPage6;

    double top = 0;
    double? left;
    double? right;

    switch (index) {
      case 0: // Lessons (Top Leftish)
        top = 200.h;
        left = 120.w;
        break;
      case 1: // Games (Top Rightish)
        top = 200.h;
        right = 140.w;
        break;
      case 2: // Chat (Bottom Leftish)
        top = 480.h;
        left = 140.w;
        break;
      case 3: // Tips (Bottom Rightish)
        top = 480.h;
        right = 120.w;
        break;
      case 4: // DyslexiaWidget (Top)
        top = 85.h;
        left = 150.w;
        break;
    }

    return Positioned(
      top: top,
      left: left,
      right: right,
      child: Image.asset(
        asset,
        width: 180.w,
      ),
    );
  }
}
