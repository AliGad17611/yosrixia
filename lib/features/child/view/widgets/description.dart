import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/view/widgets/bubble_triangle_painter.dart';
import 'package:yosrixia/core/helper/child_home_tutorial_data.dart';

class Description extends StatelessWidget {
  final int index;
  const Description({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final tutorialItem = childHomeTutorialData[index];

    double? top;
    double? bottom;
    double? left;
    double? right;

    // Position relative to arrow
    switch (index) {
      case 0: // Lessons (Arrow at 370.h, 100.w)
        bottom = MediaQuery.of(context).size.height - 200.h + 10.h;
        left = 40.w;
        right = 40.w;
        break;
      case 1: // Games (Arrow at 370.h, right 100.w)
        bottom = MediaQuery.of(context).size.height - 200.h + 10.h;
        left = 40.w;
        right = 40.w;
        break;
      case 2: // Chat (Arrow at 480.h, 100.w)
        bottom = MediaQuery.of(context).size.height - 480.h + 50.h;
        left = 40.w;
        right = 40.w;
        break;
      case 3: // Tips (Arrow at 480.h, right 100.w)
        bottom = MediaQuery.of(context).size.height - 480.h + 50.h;
        left = 40.w;
        right = 40.w;
        break;
      case 4: // DyslexiaWidget (Arrow at 85.h, left 150.w)
        top = 85.h + 120.h; // Below arrow
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
                // Bubble triangle/tail
                Positioned(
                  bottom: index == 4 ? null : -10.h,
                  top: index == 4 ? -10.h : null,
                  left: index % 2 == 0 ? 40.w : null,
                  right: index % 2 != 0 ? 40.w : null,
                  child: Transform.rotate(
                    angle: index == 4 ? 3.14 : 0,
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
