import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/core/widgets/app_usage_display.dart';

class AppUsageStatsView extends StatelessWidget {
  const AppUsageStatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF6A5ACD),
                  Color(0xFF4B0082),
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                children: [
                  // Header with back button
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => GoRouter.of(context).pop(),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'إحصائيات استخدام التطبيق',
                          style: Styles.textStyle32.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 40.w), // Balance the back button
                    ],
                  ),
                  SizedBox(height: 30.h),
                  
                  // Main stats display
                  const Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Show detailed stats with target
                          AppUsageDisplay(
                            showDailyTarget: true,
                            dailyTargetMinutes: 30,
                            showDetailedStats: true,
                          ),
                          
                          SizedBox(height: 30),
                          
                          // Encouragement section
                          EncouragementCard(),
                          
                          SizedBox(height: 20),
                          
                          // Tips section
                          TipsCard(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EncouragementCard extends StatelessWidget {
  const EncouragementCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.emoji_events,
                color: Colors.amber,
                size: 30.sp,
              ),
              SizedBox(width: 10.w),
              Text(
                'تشجيع',
                style: Styles.textStyle24.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Text(
            'أحسنت! طفلك يتقدم بشكل رائع. استمر في تشجيعه على اللعب يومياً لتحقيق أفضل النتائج.',
            style: Styles.textStyle18.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class TipsCard extends StatelessWidget {
  const TipsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final tips = [
      'حاول أن يلعب طفلك في نفس الوقت كل يوم',
      'اجلس مع طفلك أثناء اللعب لتشجيعه',
      'احتفل بإنجازات طفلك الصغيرة',
      'لا تضغط على الطفل إذا كان متعباً',
      'اجعل وقت اللعب ممتعاً وليس واجباً',
    ];
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb,
                color: Colors.yellow,
                size: 30.sp,
              ),
              SizedBox(width: 10.w),
              Text(
                'نصائح للوالدين',
                style: Styles.textStyle24.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          ...tips.map((tip) => Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• ',
                  style: Styles.textStyle18.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                Expanded(
                  child: Text(
                    tip,
                    style: Styles.textStyle18.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

