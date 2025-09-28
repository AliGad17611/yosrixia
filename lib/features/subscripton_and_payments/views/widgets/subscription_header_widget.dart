import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class SubscriptionHeaderWidget extends StatelessWidget {
  const SubscriptionHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            'اختر باقة الاشتراك',
            style: Styles.textStyle32.copyWith(
              color: kSecondaryColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        GestureDetector(
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
        ),
      ],
    );
  }
}
