import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/features/subscripton_and_payments/manger/services/payment_services.dart';

class PaymobView extends StatelessWidget {
  final double amount;
  final dynamic subscriptionType;

  const PaymobView({
    super.key,
    this.amount = 100.0,
    this.subscriptionType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header with back button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'اختر طريقة الدفع',
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
                    ), // Balance the back button
                  ],
                ),

                SizedBox(height: 20.h),

                // Payment icon
                Center(
                  child: Container(
                    width: 80.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: kBlueColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                    child: Icon(
                      Icons.payment,
                      size: 40.sp,
                      color: kBlueColor,
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // Amount display
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: kBlueColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16.r),
                    border:
                        Border.all(color: kBlueColor.withValues(alpha: 0.3)),
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
                ),

                SizedBox(height: 30.h),

                // Payment methods
                Text(
                  'اختر طريقة الدفع المناسبة',
                  style: Styles.textStyle20.copyWith(
                    color: kSecondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 20.h),

                // Card payment button
                _PaymentMethodButton(
                  icon: Icons.credit_card,
                  title: 'الدفع بالبطاقة الائتمانية',
                  subtitle: 'فيزا، ماستركارد',
                  onTap: () {
                    PaymentServices.payWithCard(context, amount,
                        subscriptionType: subscriptionType);
                  },
                ),

                SizedBox(height: 16.h),

                // Wallet payment button
                _PaymentMethodButton(
                  icon: Icons.account_balance_wallet,
                  title: 'الدفع بالمحفظة الإلكترونية',
                  subtitle: 'فودافون كاش، أورنج موني، إتصالات كاش',
                  onTap: () {
                    GoRouter.of(context).push(
                      AppRouter.walletPhone,
                      extra: {
                        'amount': amount,
                        'subscriptionType': subscriptionType,
                      },
                    );
                  },
                ),

                SizedBox(height: 20.h),

                // Security note
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.security,
                        color: Colors.green,
                        size: 16.sp,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          'جميع المدفوعات محمية بتشفير SSL وتتم معالجتها بأمان عبر Paymob',
                          style: Styles.textStyle18.copyWith(
                            color: kSecondaryColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PaymentMethodButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _PaymentMethodButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: kBlueColor.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: kBlueColor.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: kBlueColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: kBlueColor,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Styles.textStyle18.copyWith(
                      color: kSecondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: Styles.textStyle18.copyWith(
                      color: kSecondaryColor.withValues(alpha: 0.7),
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: kBlueColor,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
