import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/widgets/category.dart';

class LettersQuizViewBody extends StatelessWidget {
  const LettersQuizViewBody({super.key});

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
              const Spacer(
                flex: 2,
              ),
              Text(
                'حروف',
                style: Styles.textStyle96,
              ),
              const Spacer(
                flex: 3,
              ),
              Category(
                text: 'تجميع الحرف',
                onTap: () {
                  GoRouter.of(context).push(AppRouter.puzzel);
                },
              ),
              const SizedBox(height: 30),
              Category(
                text: 'كتابة الحرف',
                onTap: () {
                  GoRouter.of(context).push(AppRouter.handwriting);
                },
              ),
              const SizedBox(height: 30),
              Category(
                text: 'مطابقة البطاقات',
                onTap: () {
                  GoRouter.of(context).push(AppRouter.identicalCharacter);
                },
              ),
              const SizedBox(height: 30),
              Category(
                text: 'البحث عن الحرف',
                onTap: () {
                  GoRouter.of(context).push(AppRouter.identicalCharacter);
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
