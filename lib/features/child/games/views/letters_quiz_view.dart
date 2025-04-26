import 'package:flutter/material.dart';
import 'package:yosrixia/features/child/games/views/widgets/letters_quiz_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class LettersQuizView extends StatelessWidget {
  const LettersQuizView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: LettersQuizViewBody(),);
  }
}
