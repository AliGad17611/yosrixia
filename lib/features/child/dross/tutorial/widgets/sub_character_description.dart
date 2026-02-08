import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yosrixia/core/helper/sub_character_tutorial_data.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/view/widgets/bubble_triangle_painter.dart';

class SubCharacterDescription extends StatelessWidget {
  final int index;
  const SubCharacterDescription({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    if (index >= subCharacterTutorialData.length) {
      return const SizedBox.shrink();
    }

    final tutorialItem = subCharacterTutorialData[index];

    double? top;
    double? bottom;
    double? left;
    double? right;

    switch (index) {
      case 0: // Sound box (Arrow at top: 220.h)
        top = 220.h + 120.h;
        left = 40.w;
        right = 40.w;
        break;
      case 1: // Mic icon (Arrow at top: 370.h)
        top = 370.h + 100.h;
        left = 40.w;
        right = 40.w;
        break;
      case 2: // Bottom widget (Arrow at bottom: 85.h)
        bottom = 200.h;
        left = 40.w;
        right = 40.w;
        break;
    }

    return Positioned(
      top: top,
      bottom: bottom,
      right: right,
      left: left,
      child: Center(
        child: IntrinsicWidth(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    tutorialItem,
                    textAlign: TextAlign.center,
                    style: Styles.textStyle24.copyWith(
                      color: kSecondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  bottom: index == 2 ? -10.h : null,
                  top: index != 2 ? -10.h : null,
                  left: index % 2 != 0 ? 40.w : null,
                  right: index % 2 == 0 ? 40.w : null,
                  child: Transform.rotate(
                    angle: index != 2 ? 3.14 : 0,
                    child: CustomPaint(
                      painter: BubbleTrianglePainter(),
                      size: Size(20.w, 10.h),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
