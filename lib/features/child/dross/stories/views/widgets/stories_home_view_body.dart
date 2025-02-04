import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/helper/global_variable.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/widgets/category.dart';

class StoriesHomeViewBody extends StatelessWidget {
  const StoriesHomeViewBody({super.key});

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
                'قصص',
                style: Styles.textStyle96,
              ),
              const SizedBox(height: 126),
              Category(
                text: 'الصياد الماهر',
                onTap: () {
                  storyTitle = 'الصياد الماهر';
                  GoRouter.of(context).push(AppRouter.story);
                },
              ),
              const SizedBox(height: 46),
              Category(
                  text: 'نهاية الشقاوة',
                  onTap: () {
                    storyTitle = 'نهاية الشقاوة';
                    GoRouter.of(context).push(AppRouter.story);
                  }),
              const SizedBox(height: 46),
              Category(
                  text: 'الدب و الصديقان',
                  onTap: () {
                    storyTitle = 'الدب و الصديقان';
                    GoRouter.of(context).push(AppRouter.story);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
