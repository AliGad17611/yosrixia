import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class ButtonContent extends StatelessWidget {
  const ButtonContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.payment,
          color: kPrimaryColor,
          size: 20.sp,
        ),
        SizedBox(width: 10.w),
        Text(
          'ادفع الآن',
          style: Styles.textStyle20.copyWith(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
