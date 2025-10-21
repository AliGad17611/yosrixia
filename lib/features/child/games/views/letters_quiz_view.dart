import 'package:flutter/material.dart';
import 'package:yosrixia/features/subscripton_and_payments/views/subscription_guard.dart';
import 'package:yosrixia/features/child/games/views/widgets/letters_quiz_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class LettersQuizView extends StatelessWidget {
  const LettersQuizView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SubscriptionGuard(
      child: BackGround(child: LettersQuizViewBody()),
    );
  }
}
