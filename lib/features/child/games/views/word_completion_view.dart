import 'package:flutter/material.dart';
import 'package:yosrixia/features/child/games/views/widgets/word_completion_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class WordCompletionView extends StatelessWidget {
  const WordCompletionView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: WordCompletionViewBody(),);
  }
}