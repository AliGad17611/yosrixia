import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/responsive/widget_height.dart';
import 'package:yosrixia/core/responsive/widget_width.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class ChildCategory extends StatelessWidget {
  const ChildCategory(
      {super.key,
      this.scale = 1,
      required this.text,
      required this.image,
      this.fontSize = 40});
  final String text;
  final String image;
  final double scale;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (text == 'دروس') {
          GoRouter.of(context).push(AppRouter.droosHome);
        } else if (text == 'العاب تعليمية') {
          GoRouter.of(context).push(AppRouter.gamesHome);
        } else if (text == 'أطباء') {
          GoRouter.of(context).push(AppRouter.showAllDoctorsView);
        } else if (text == 'نصائح') {
          GoRouter.of(context).push(AppRouter.tips);
        }
      },
      child: Container(
        width: widgetWidth(context: context, width: 177),
        height: widgetHeight(context: context, height: 190),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: kPrimaryColor,
        ),
        child: Column(
          children: [
            SizedBox(
              height: widgetHeight(context: context, height: 135),
              child: Transform.scale(
                scale: scale,
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              text,
              style: Styles.textStyle40Passion
                  .copyWith(color: kBlueColor, fontSize: fontSize),
            )
          ],
        ),
      ),
    );
  }
}
