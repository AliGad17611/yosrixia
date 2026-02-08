import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yosrixia/core/utils/assets_data.dart';
import 'package:yosrixia/features/child/view/widgets/child_category.dart';
import 'package:yosrixia/features/child/view/widgets/dyslexia_widget.dart';

class FocusedCategory extends StatelessWidget {
  final int index;
  const FocusedCategory({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 23, left: 23),
      child: Column(
        children: [
          // Index 4 focuses on DyslexiaWidget
          Opacity(
            opacity: index == 4 ? 1 : 0,
            child: const IgnorePointer(
              ignoring: true,
              child: DyslexiaWidget(),
            ),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(height: 89.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Index 0: Lessons
                    Opacity(
                      opacity: index == 0 ? 1 : 0,
                      child: const IgnorePointer(
                        ignoring: true,
                        child: ChildCategory(
                          scale: 1.7,
                          image: AssetsData.lessons,
                          text: 'دروس',
                        ),
                      ),
                    ),
                    // Index 1: Games
                    Opacity(
                      opacity: index == 1 ? 1 : 0,
                      child: const IgnorePointer(
                        ignoring: true,
                        child: ChildCategory(
                          scale: 0.9,
                          image: AssetsData.games,
                          text: 'العاب تعليمية',
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Index 2: Chat
                    Opacity(
                      opacity: index == 2 ? 1 : 0,
                      child: const IgnorePointer(
                        ignoring: true,
                        child: ChildCategory(
                          scale: 0.9,
                          image: AssetsData.chat,
                          text: 'صحابى',
                        ),
                      ),
                    ),
                    // Index 3: Tips
                    Opacity(
                      opacity: index == 3 ? 1 : 0,
                      child: const IgnorePointer(
                        ignoring: true,
                        child: ChildCategory(
                          scale: 0.9,
                          image: AssetsData.tips,
                          text: 'نصائح',
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
