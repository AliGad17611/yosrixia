import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class TutorialNextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLast;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;

  const TutorialNextButton({
    super.key,
    required this.onPressed,
    required this.isLast,
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom ?? 50.h,
      right: right ?? (left == null ? 40.w : null),
      left: left,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          isLast ? 'ابدأ الآن' : 'التالي',
          style: Styles.textStyle32.copyWith(
            color: kBlueColor,
          ),
        ),
      ),
    );
  }
}
