import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/subscripton_and_payments/manger/cubit/subscription_home_cubit.dart';

class PlanCardWidget extends StatelessWidget {
  final Map<String, dynamic> plan;
  final bool isSelected;

  const PlanCardWidget({
    super.key,
    required this.plan,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isPopular = plan['popular'] == true;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              context.read<SubscriptionHomeCubit>().selectPlan(plan['type']);
            },
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? kBlueColor.withValues(alpha: 0.1)
                    : kPrimaryColor,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: isSelected
                      ? kBlueColor
                      : kBlueColor.withValues(alpha: 0.3),
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: kBlueColor.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isPopular) SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        plan['title'],
                        style: Styles.textStyle20.copyWith(
                          color: kSecondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isSelected)
                        Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: const BoxDecoration(
                            color: kBlueColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: kPrimaryColor,
                            size: 16.sp,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Text(
                        '${plan['price']} جنيه',
                        style: Styles.textStyle24.copyWith(
                          color: kBlueColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (plan['originalPrice'] != null) ...[
                        SizedBox(width: 8.w),
                        Text(
                          '${plan['originalPrice']} جنيه',
                          style: Styles.textStyle18.copyWith(
                            color: kSecondaryColor.withValues(alpha: 0.6),
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                      const Spacer(),
                      Text(
                        plan['duration'],
                        style: Styles.textStyle18.copyWith(
                          color: kSecondaryColor.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                  if (plan['discount'] != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      'وفر ${plan['discount']}',
                      style: Styles.textStyle18.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (isPopular)
            Positioned(
              top: -8.h,
              right: 20.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'الأكثر شعبية',
                  style: Styles.textStyle18.copyWith(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
