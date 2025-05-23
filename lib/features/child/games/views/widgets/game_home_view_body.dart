import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/widgets/category.dart';

class GameHomeViewBody extends StatelessWidget {
  const GameHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 45, right: 16, left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'ألعاب',
                style: Styles.textStyle96,
              ),
              const Spacer(
                flex: 3,
              ),
              Category(
                text: 'حروف',
                onTap: () {
                  GoRouter.of(context).push(AppRouter.lettersQuiz);
                },
              ),
              const SizedBox(height: 46),
              Category(
                text: 'كلمات',
                onTap: () {
                  GoRouter.of(context).push(AppRouter.wordsQuiz);
                },
              ),
              const Spacer(
                flex: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
