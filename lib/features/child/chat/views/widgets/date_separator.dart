import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class DateSeparator extends StatelessWidget {
  final DateTime date;

  const DateSeparator({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              color: kPrimaryColor.withValues(alpha: 0.2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: kPrimaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: kPrimaryColor.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Text(
                _formatDate(date),
                style: Styles.textStyle18.copyWith(
                  fontSize: 14,
                  color: kPrimaryColor.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 1,
              color: kPrimaryColor.withValues(alpha: 0.2),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(date.year, date.month, date.day);

    if (messageDate == today) {
      return 'اليوم';
    } else if (messageDate == yesterday) {
      return 'أمس';
    } else {
      // Check if it's within this week
      final daysAgo = today.difference(messageDate).inDays;
      if (daysAgo <= 7) {
        return _getArabicWeekday(date.weekday);
      } else if (date.year == now.year) {
        // Same year, show month and day
        return '${date.day} ${_getArabicMonth(date.month)}';
      } else {
        // Different year, show full date
        return '${date.day} ${_getArabicMonth(date.month)} ${date.year}';
      }
    }
  }

  String _getArabicWeekday(int weekday) {
    const weekdays = [
      'الاثنين', // Monday
      'الثلاثاء', // Tuesday
      'الأربعاء', // Wednesday
      'الخميس', // Thursday
      'الجمعة', // Friday
      'السبت', // Saturday
      'الأحد', // Sunday
    ];
    return weekdays[weekday - 1];
  }

  String _getArabicMonth(int month) {
    const months = [
      'يناير', // January
      'فبراير', // February
      'مارس', // March
      'أبريل', // April
      'مايو', // May
      'يونيو', // June
      'يوليو', // July
      'أغسطس', // August
      'سبتمبر', // September
      'أكتوبر', // October
      'نوفمبر', // November
      'ديسمبر', // December
    ];
    return months[month - 1];
  }
}
