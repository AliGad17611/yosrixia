import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class AmountDisplay extends StatelessWidget {
  final double amount;

  const AmountDisplay({
    super.key,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: kBlueColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: kBlueColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            'المبلغ المطلوب',
            style: Styles.textStyle18.copyWith(
              color: kSecondaryColor,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '${amount.toStringAsFixed(2)} جنيه مصري',
            style: Styles.textStyle24.copyWith(
              color: kBlueColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
