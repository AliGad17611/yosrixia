import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yosrixia/core/utils/constants.dart';

class WalletIcon extends StatelessWidget {
  const WalletIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 80.w,
        height: 80.h,
        decoration: BoxDecoration(
          color: kBlueColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(40.r),
        ),
        child: Icon(
          Icons.account_balance_wallet,
          size: 40.sp,
          color: kBlueColor,
        ),
      ),
    );
  }
}
