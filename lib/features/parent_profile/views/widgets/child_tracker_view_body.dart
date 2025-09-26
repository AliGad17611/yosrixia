import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/core/widgets/app_usage_display.dart';

class ChildTrackerViewBody extends StatelessWidget {
  const ChildTrackerViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              children: [
                const ChildActivityHeader(),
                SizedBox(height: 30.h),
                const ReminderText(),
                SizedBox(height: 40.h),
                const AppUsageDisplay(
                  showDailyTarget: true,
                  dailyTargetMinutes: 30,
                  showDetailedStats: true,
                ),
                const Spacer(),
                // const LetterButtonsGrid(),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChildActivityHeader extends StatelessWidget {
  const ChildActivityHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 30.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Text(
        'نشاط الطفل',
        style: Styles.textStyle32.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class ReminderText extends StatelessWidget {
  const ReminderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'تذكر:',
          style: Styles.textStyle24.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'يجب عليك اللعب يوميا ليستمر التطور',
          style: Styles.textStyle20.copyWith(
            color: Colors.white.withValues(alpha: 0.9),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class LetterButtonsGrid extends StatelessWidget {
  const LetterButtonsGrid({super.key});

  final List<String> arabicLetters = const [
    'س',
    'ح',
    'ن',
    'ت',
    'ر',
    'خ',
    'ج',
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 15.w,
      runSpacing: 15.h,
      alignment: WrapAlignment.center,
      children: arabicLetters.map((letter) {
        return LetterButton(letter: letter);
      }).toList(),
    );
  }
}

class LetterButton extends StatelessWidget {
  final String letter;

  const LetterButton({
    super.key,
    required this.letter,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle letter button tap
        // You can add navigation or action here
      },
      borderRadius: BorderRadius.circular(50.r),
      child: Container(
        width: 70.w,
        height: 70.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.2),
          border: Border.all(
            color: Colors.white,
            width: 3.w,
          ),
        ),
        child: Center(
          child: Text(
            letter,
            style: Styles.textStyle40.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
