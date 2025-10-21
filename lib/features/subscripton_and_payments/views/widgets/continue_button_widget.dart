import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/subscripton_and_payments/manger/cubit/subscription_home_cubit.dart';
import 'package:yosrixia/features/subscripton_and_payments/manger/cubit/subscription_home_state.dart';

class ContinueButtonWidget extends StatelessWidget {
  const ContinueButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionHomeCubit, SubscriptionHomeState>(
      builder: (context, state) {
        if (state is! SubscriptionHomeLoaded) return const SizedBox.shrink();

        final isEnabled = state.selectedPlan != null;
        final isCouponValid = state.couponCode.trim().isNotEmpty &&
            state.couponMessage?.contains('صالح') == true;

        return GestureDetector(
          onTap: isEnabled
              ? () =>
                  context.read<SubscriptionHomeCubit>().proceedWithPlan(context)
              : null,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            decoration: BoxDecoration(
              color: isEnabled ? kBlueColor : kBlueColor.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              isCouponValid ? 'تفعيل الاشتراك المجاني' : 'المتابعة للدفع',
              style: Styles.textStyle18.copyWith(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
