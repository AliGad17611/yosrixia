import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/dross/views/widgets/dross_category.dart';

class WordHomeViewBody extends StatelessWidget {
  const WordHomeViewBody({super.key});

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
                'كلمات',
                style: Styles.textStyle96,
              ),
              const Spacer(
                flex: 3,
              ),
              DrossCategory(
                text: 'اختيارات',
                onTap: () {
                  // GoRouter.of(context).push(AppRouter.imagesName);
                },
              ),
              const SizedBox(height: 46),
              DrossCategory(
                text: 'تكملة',
                onTap: () {
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
