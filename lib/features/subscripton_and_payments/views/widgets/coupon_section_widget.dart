import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/subscripton_and_payments/manger/cubit/subscription_home_cubit.dart';
import 'package:yosrixia/features/subscripton_and_payments/manger/cubit/subscription_home_state.dart';

class CouponSectionWidget extends StatefulWidget {
  const CouponSectionWidget({super.key});

  @override
  State<CouponSectionWidget> createState() => _CouponSectionWidgetState();
}

class _CouponSectionWidgetState extends State<CouponSectionWidget> {
  final TextEditingController _couponController = TextEditingController();

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionHomeCubit, SubscriptionHomeState>(
      builder: (context, state) {
        if (state is! SubscriptionHomeLoaded) return const SizedBox.shrink();

        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: kBlueColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: kBlueColor.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'هل لديك كوبون خصم؟',
                style: Styles.textStyle18.copyWith(
                  color: kSecondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _couponController,
                      decoration: InputDecoration(
                        hintText: 'أدخل كود الكوبون',
                        hintStyle: Styles.textStyle18.copyWith(
                          color: kSecondaryColor.withValues(alpha: 0.6),
                        ),
                        filled: true,
                        fillColor: kPrimaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                              color: kBlueColor.withValues(alpha: 0.3)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                              color: kBlueColor.withValues(alpha: 0.3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(color: kBlueColor),
                        ),
                      ),
                      style:
                          Styles.textStyle18.copyWith(color: kSecondaryColor),
                      onChanged: (value) {
                        context
                            .read<SubscriptionHomeCubit>()
                            .updateCouponCode(value);
                      },
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: (state.isValidatingCoupon ||
                            state.couponCode.trim().isEmpty)
                        ? null
                        : () => context
                            .read<SubscriptionHomeCubit>()
                            .validateCoupon(),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: state.couponCode.trim().isEmpty
                            ? kBlueColor.withValues(alpha: 0.5)
                            : kBlueColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: state.isValidatingCoupon
                          ? SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: const CircularProgressIndicator(
                                color: kPrimaryColor,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'تحقق',
                              style: Styles.textStyle18.copyWith(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
              if (state.couponMessage != null) ...[
                SizedBox(height: 8.h),
                Text(
                  state.couponMessage!,
                  style: Styles.textStyle18.copyWith(
                    color: state.couponMessage!.contains('صالح')
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
