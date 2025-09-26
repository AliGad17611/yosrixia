import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:yosrixia/core/services/app_usage_tracker.dart';
import 'package:yosrixia/core/utils/styles.dart';

class AppUsageDisplay extends StatefulWidget {
  final bool showDailyTarget;
  final int dailyTargetMinutes;
  final bool showDetailedStats;
  
  const AppUsageDisplay({
    super.key,
    this.showDailyTarget = true,
    this.dailyTargetMinutes = 30,
    this.showDetailedStats = false,
  });

  @override
  State<AppUsageDisplay> createState() => _AppUsageDisplayState();
}

class _AppUsageDisplayState extends State<AppUsageDisplay> {
  late AppUsageTracker _tracker;
  
  @override
  void initState() {
    super.initState();
    _tracker = AppUsageTracker();
    
    // Update UI every 30 seconds to show real-time usage
    Future.delayed(Duration.zero, () {
      if (mounted) {
        _startPeriodicUpdate();
      }
    });
  }
  
  void _startPeriodicUpdate() {
    Future.delayed(const Duration(seconds: 30), () {
      if (mounted) {
        setState(() {});
        _startPeriodicUpdate();
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final currentMinutes = _tracker.getTodayUsageMinutes();
    final percentage = widget.showDailyTarget 
        ? (currentMinutes / widget.dailyTargetMinutes).clamp(0.0, 1.0)
        : 0.0;
    
    if (widget.showDetailedStats) {
      return _buildDetailedStats(currentMinutes, percentage);
    } else {
      return _buildSimpleStats(currentMinutes, percentage);
    }
  }
  
  Widget _buildSimpleStats(int currentMinutes, double percentage) {
    return CircularPercentIndicator(
      radius: 120.r,
      lineWidth: 15.w,
      percent: percentage,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.showDailyTarget 
                ? '$currentMinutes/${widget.dailyTargetMinutes}'
                : '$currentMinutes',
            style: Styles.textStyle48.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'دقيقة اليوم',
            style: Styles.textStyle32.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
      progressColor: percentage >= 1.0 ? Colors.green : Colors.white,
      backgroundColor: Colors.white.withValues(alpha: 0.3),
      circularStrokeCap: CircularStrokeCap.round,
      animation: true,
      animationDuration: 1500,
    );
  }
  
  Widget _buildDetailedStats(int currentMinutes, double percentage) {
    return Container(
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
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSimpleStats(currentMinutes, percentage),
          SizedBox(height: 20.h),
          const Divider(color: Colors.white24),
          SizedBox(height: 15.h),
          _buildStatRow('اليوم', _tracker.dailyUsageFormatted, Icons.today),
          SizedBox(height: 10.h),
          _buildStatRow('هذا الأسبوع', _tracker.weeklyUsageFormatted, Icons.date_range),
          SizedBox(height: 10.h),
          _buildStatRow('هذا الشهر', _tracker.monthlyUsageFormatted, Icons.calendar_month),
          SizedBox(height: 10.h),
          _buildStatRow('الإجمالي', _tracker.totalUsageFormatted, Icons.access_time_filled),
        ],
      ),
    );
  }
  
  Widget _buildStatRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white70,
          size: 20.sp,
        ),
        SizedBox(width: 10.w),
        Text(
          label,
          style: Styles.textStyle18.copyWith(
            color: Colors.white70,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: Styles.textStyle20.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// Compact version for showing in app bars or small spaces
class AppUsageCompactDisplay extends StatefulWidget {
  const AppUsageCompactDisplay({super.key});

  @override
  State<AppUsageCompactDisplay> createState() => _AppUsageCompactDisplayState();
}

class _AppUsageCompactDisplayState extends State<AppUsageCompactDisplay> {
  late AppUsageTracker _tracker;
  
  @override
  void initState() {
    super.initState();
    _tracker = AppUsageTracker();
    _startPeriodicUpdate();
  }
  
  void _startPeriodicUpdate() {
    Future.delayed(const Duration(seconds: 30), () {
      if (mounted) {
        setState(() {});
        _startPeriodicUpdate();
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final minutes = _tracker.getTodayUsageMinutes();
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.access_time,
            color: Colors.white,
            size: 18.sp,
          ),
          SizedBox(width: 6.w),
          Text(
            '$minutes دقيقة',
            style: Styles.textStyle18.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
