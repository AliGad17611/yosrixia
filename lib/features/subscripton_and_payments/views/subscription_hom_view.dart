import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/features/subscripton_and_payments/manger/cubit/subscription_home_cubit.dart';
import 'package:yosrixia/features/subscripton_and_payments/manger/cubit/subscription_home_state.dart';
import 'package:yosrixia/features/subscripton_and_payments/views/widgets/subscription_header_widget.dart';
import 'package:yosrixia/features/subscripton_and_payments/views/widgets/coupon_section_widget.dart';
import 'package:yosrixia/features/subscripton_and_payments/views/widgets/plan_card_widget.dart';
import 'package:yosrixia/features/subscripton_and_payments/views/widgets/continue_button_widget.dart';

class SubscriptionHomView extends StatelessWidget {
  const SubscriptionHomView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubscriptionHomeCubit(),
      child: const SubscriptionHomViewBody(),
    );
  }
}

class SubscriptionHomViewBody extends StatelessWidget {
  const SubscriptionHomViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SubscriptionHomeCubit, SubscriptionHomeState>(
      listener: (context, state) {
        if (state is SubscriptionHomeSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is SubscriptionHomeError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  const SubscriptionHeaderWidget(),

                  SizedBox(height: 20.h),

                  // Coupon Section
                  const CouponSectionWidget(),

                  SizedBox(height: 20.h),

                  // Plans Section
                  Expanded(
                    child: BlocBuilder<SubscriptionHomeCubit,
                        SubscriptionHomeState>(
                      builder: (context, state) {
                        if (state is! SubscriptionHomeLoaded) {
                          return const SizedBox.shrink();
                        }

                        return ListView.builder(
                          itemCount: SubscriptionHomeCubit.plans.length,
                          itemBuilder: (context, index) {
                            final plan = SubscriptionHomeCubit.plans[index];
                            final isSelected =
                                state.selectedPlan == plan['type'];

                            return PlanCardWidget(
                              plan: plan,
                              isSelected: isSelected,
                            );
                          },
                        );
                      },
                    ),
                  ),

                  // Continue Button
                  const ContinueButtonWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
