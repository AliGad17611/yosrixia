import 'package:flutter/material.dart';
import 'package:yosrixia/features/child/games/puzzel/views/widgets/puzzel_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';
import 'package:yosrixia/features/subscripton_and_payments/views/subscription_guard.dart';

class PuzzelView extends StatelessWidget {
  const PuzzelView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(
      child: SubscriptionGuard(child: PuzzelViewBody()),
    );
  }
}
