import 'package:equatable/equatable.dart';
import 'package:yosrixia/features/subscripton_and_payments/manger/helper/subscription_enum.dart';

abstract class SubscriptionHomeState extends Equatable {
  const SubscriptionHomeState();

  @override
  List<Object?> get props => [];
}

class SubscriptionHomeInitial extends SubscriptionHomeState {}

class SubscriptionHomeLoaded extends SubscriptionHomeState {
  final SubscriptionType? selectedPlan;
  final bool isValidatingCoupon;
  final String? couponMessage;
  final String couponCode;

  const SubscriptionHomeLoaded({
    this.selectedPlan,
    this.isValidatingCoupon = false,
    this.couponMessage,
    this.couponCode = '',
  });

  SubscriptionHomeLoaded copyWith({
    SubscriptionType? selectedPlan,
    bool? isValidatingCoupon,
    String? couponMessage,
    String? couponCode,
  }) {
    return SubscriptionHomeLoaded(
      selectedPlan: selectedPlan ?? this.selectedPlan,
      isValidatingCoupon: isValidatingCoupon ?? this.isValidatingCoupon,
      couponMessage: couponMessage,
      couponCode: couponCode ?? this.couponCode,
    );
  }

  @override
  List<Object?> get props => [
        selectedPlan,
        isValidatingCoupon,
        couponMessage,
        couponCode,
      ];
}

class SubscriptionHomeError extends SubscriptionHomeState {
  final String message;

  const SubscriptionHomeError(this.message);

  @override
  List<Object> get props => [message];
}

class SubscriptionHomeSuccess extends SubscriptionHomeState {
  final String message;

  const SubscriptionHomeSuccess(this.message);

  @override
  List<Object> get props => [message];
}
