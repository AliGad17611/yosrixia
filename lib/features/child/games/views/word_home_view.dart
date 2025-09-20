import 'package:flutter/material.dart';
import 'package:yosrixia/features/subscripton_and_payments/widgets/subscription_guard.dart';
import 'package:yosrixia/features/child/games/views/widgets/word_home_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class WordHomeView extends StatelessWidget {
  const WordHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SubscriptionGuard(
      child: BackGround(child: WordHomeViewBody()),
    );
  }
}
