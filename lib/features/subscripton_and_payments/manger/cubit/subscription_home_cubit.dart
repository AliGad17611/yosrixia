import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/features/subscripton_and_payments/manger/cubit/subscription_home_state.dart';
import 'package:yosrixia/features/subscripton_and_payments/manger/helper/subscription_enum.dart';
import 'package:yosrixia/features/subscripton_and_payments/manger/services/coupon_service.dart';
import 'package:yosrixia/features/subscripton_and_payments/manger/services/subscription_services.dart';

class SubscriptionHomeCubit extends Cubit<SubscriptionHomeState> {
  SubscriptionHomeCubit() : super(SubscriptionHomeInitial()) {
    _loadInitialState();
  }

  static final List<Map<String, dynamic>> plans = [
    {
      'type': SubscriptionType.monthly,
      'title': 'الباقة الشهرية',
      'price': 50.0,
      'duration': '30 يوم',
    },
    {
      'type': SubscriptionType.quarterly,
      'title': 'الباقة ربع السنوية',
      'price': 120.0,
      'originalPrice': 150.0,
      'duration': '3 أشهر',
      'discount': '20%',
    },
    {
      'type': SubscriptionType.halfYearly,
      'title': 'الباقة نصف السنوية',
      'price': 200.0,
      'originalPrice': 300.0,
      'duration': '6 أشهر',
      'discount': '33%',
      'popular': true,
    },
    {
      'type': SubscriptionType.yearly,
      'title': 'الباقة السنوية',
      'price': 350.0,
      'originalPrice': 600.0,
      'duration': 'سنة كاملة',
      'discount': '42%',
    },
  ];

  void _loadInitialState() {
    emit(const SubscriptionHomeLoaded());
  }

  void selectPlan(SubscriptionType planType) {
    final currentState = state;
    if (currentState is SubscriptionHomeLoaded) {
      emit(currentState.copyWith(selectedPlan: planType));
    }
  }

  void updateCouponCode(String couponCode) {
    final currentState = state;
    if (currentState is SubscriptionHomeLoaded) {
      if (couponCode.isEmpty) {
        emit(currentState.copyWith(
          couponCode: couponCode,
          couponMessage: null,
        ));
      } else {
        emit(currentState.copyWith(couponCode: couponCode));
      }
    }
  }

  Future<void> validateCoupon() async {
    final currentState = state;
    if (currentState is! SubscriptionHomeLoaded ||
        currentState.couponCode.trim().isEmpty) {
      return;
    }

    emit(currentState.copyWith(
      isValidatingCoupon: true,
      couponMessage: null,
    ));

    try {
      final isValid =
          await CouponService.validateCoupon(currentState.couponCode.trim());

      emit(currentState.copyWith(
        isValidatingCoupon: false,
        couponMessage: isValid
            ? 'الكوبون صالح! ستحصل على اشتراك سنوي مجاني'
            : 'الكوبون غير صالح أو منتهي الصلاحية',
      ));
    } catch (e) {
      emit(currentState.copyWith(
        isValidatingCoupon: false,
        couponMessage: 'حدث خطأ أثناء التحقق من الكوبون',
      ));
    }
  }

  Future<void> proceedWithPlan(BuildContext context) async {
    final currentState = state;
    if (currentState is! SubscriptionHomeLoaded ||
        currentState.selectedPlan == null) {
      return;
    }

    // Check if coupon is valid and applied
    if (currentState.couponCode.trim().isNotEmpty &&
        currentState.couponMessage?.contains('صالح') == true) {
      // Apply free yearly subscription
      try {
        await SubscriptionServices.createSubscription(SubscriptionType.yearly);
        await CouponService.markCouponAsUsed(currentState.couponCode.trim());

        emit(const SubscriptionHomeSuccess(
            'تم تفعيل الاشتراك السنوي المجاني بنجاح!'));

        if (context.mounted) {
          GoRouter.of(context).pop();
        }
      } catch (e) {
        emit(const SubscriptionHomeError('حدث خطأ أثناء تفعيل الاشتراك'));
      }
    } else {
      // Proceed to payment
      final selectedPlanData = plans.firstWhere(
        (plan) => plan['type'] == currentState.selectedPlan,
      );

      if (context.mounted) {
        GoRouter.of(context).push(
          AppRouter.paymobView,
          extra: {
            'amount': selectedPlanData['price'],
            'subscriptionType': currentState.selectedPlan,
          },
        );
      }
    }
  }

  void clearMessages() {
    final currentState = state;
    if (currentState is SubscriptionHomeLoaded) {
      emit(currentState.copyWith(couponMessage: null));
    }
  }
}
