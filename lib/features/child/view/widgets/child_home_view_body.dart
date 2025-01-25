import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/assets_data.dart';
import 'package:yosrixia/features/child/view/widgets/child_category.dart';
import 'package:yosrixia/features/child/view/widgets/dyslexia_widget.dart';

class ChildHomeViewBody extends StatelessWidget {
  const ChildHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 40, right: 23, left: 23),
        child: Column(
          children: [
            DyslexiaWidget(),
            Center(
              child: Column(
                children: [
                  SizedBox(height: 89),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ChildCategory(
                        scale: 1.7,
                        image: AssetsData.lessons,
                        text: 'دروس',
                      ),
                      ChildCategory(
                        scale: 0.9,
                        image: AssetsData.games,
                        text: 'العاب تعليمية',
                        fontSize: 32,
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ChildCategory(
                        scale: 0.9,
                        image: AssetsData.doctors,
                        text: 'أطباء',
                      ),
                      ChildCategory(
                        scale: 0.9,
                        image: AssetsData.tips,
                        text: 'نصائح',
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
