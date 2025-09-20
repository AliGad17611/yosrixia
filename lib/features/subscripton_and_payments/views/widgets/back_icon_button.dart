import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/utils/constants.dart';

class BackIconButton extends StatelessWidget {
  const BackIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).pop(),
      child: Container(
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: kBlueColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(
          Icons.arrow_forward_ios,
          color: kPrimaryColor,
          size: 24.sp,
        ),
      ),
    );
  }
}
