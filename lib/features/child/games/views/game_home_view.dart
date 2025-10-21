import 'package:flutter/material.dart';
import 'package:yosrixia/features/child/games/views/widgets/game_home_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';
import 'package:yosrixia/features/subscripton_and_payments/views/subscription_guard.dart';

class GameHomeView extends StatelessWidget {
  const GameHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SubscriptionGuard(
      child: BackGround(child: Center(child: GameHomeViewBody())),
    );
  }
}
