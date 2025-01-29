import 'package:flutter/material.dart';
import 'package:yosrixia/core/helper/global_variable.dart';
import 'package:yosrixia/features/child/dross/gomal/models/gomal_model.dart';
import 'package:yosrixia/features/child/dross/helper/gomal_map.dart';
import 'package:yosrixia/features/child/dross/views/widgets/sentence_widget.dart';

class GomalLevelViewBody extends StatelessWidget {
  const GomalLevelViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: 0);
    final List<GomalModel> sentencesList = gomalMap['المستوي $gomalLevel'] ?? [];
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: 12,
        itemBuilder: (context, pageViewIndex) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SentenceWidget(gomalModel: sentencesList[pageViewIndex]),
          );
        },
      ),
    );
  }
}
