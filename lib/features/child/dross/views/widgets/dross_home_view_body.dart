import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/dross/views/widgets/dross_category.dart';

class DrossHomeViewBody extends StatelessWidget {
  const DrossHomeViewBody({super.key});

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
                'دروس',
                style: Styles.textStyle96,
              ),
              const SizedBox(height: 126),
              DrossCategory(
                text: 'حروف و كلمات',
                onTap: () {
                  GoRouter.of(context).push(AppRouter.characters);
                },
              ),
              const SizedBox(height: 46),
              DrossCategory(
                  text: 'جمل',
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.aleph1);
                  }),
              const SizedBox(height: 46),
              DrossCategory(
                  text: 'قصص',
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.aleph1);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
