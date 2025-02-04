import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/helper/global_variable.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/widgets/category.dart';

class GomalHomeViewBody extends StatelessWidget {
  const GomalHomeViewBody({super.key});

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
                'جمل',
                style: Styles.textStyle96,
              ),
              const SizedBox(height: 126),
              Category(
                text: 'المستوي 1',
                onTap: () {
                  gomalLevel = 1;
                  GoRouter.of(context).push(AppRouter.level);
                },
              ),
              const SizedBox(height: 46),
              Category(
                  text: 'المستوي 2',
                  onTap: () {
                    gomalLevel = 2;
                    GoRouter.of(context).push(AppRouter.level);
                  }),
              const SizedBox(height: 46),
              Category(
                  text: 'المستوي 3',
                  onTap: () {
                    gomalLevel = 3;
                    GoRouter.of(context).push(AppRouter.level);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
