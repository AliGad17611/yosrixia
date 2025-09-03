/// Utility class for formatting message timestamps
class TimeFormatter {
  /// Formats a DateTime to a user-friendly Arabic time string
  static String formatMessageTime(DateTime timestamp) {
    final now = DateTime.now();
    final isToday = _isSameDay(now, timestamp);
    final isYesterday = _isSameDay(
      now.subtract(const Duration(days: 1)),
      timestamp,
    );

    // Format time in 12-hour format with Arabic AM/PM
    final timeString = _formatTime12Hour(timestamp);

    if (isToday) {
      return timeString;
    } else if (isYesterday) {
      return 'أمس $timeString';
    } else {
      // For older messages, show date and time
      final day = timestamp.day.toString().padLeft(2, '0');
      final month = timestamp.month.toString().padLeft(2, '0');
      return '$day/$month $timeString';
    }
  }

  /// Formats time in 12-hour format with Arabic AM/PM indicators
  static String _formatTime12Hour(DateTime timestamp) {
    final hour = timestamp.hour == 0
        ? 12
        : (timestamp.hour > 12 ? timestamp.hour - 12 : timestamp.hour);
    final minute = timestamp.minute.toString().padLeft(2, '0');
    final period = timestamp.hour < 12 ? 'ص' : 'م';
    return '$hour:$minute $period';
  }

  /// Checks if two dates are on the same day
  static bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// Determines if a timestamp needs to be updated (for timer optimization)
  static bool shouldUpdateTime(DateTime timestamp) {
    final now = DateTime.now();
    final isToday = _isSameDay(now, timestamp);

    // Only need to update if it's today and we're close to midnight
    if (isToday) {
      final minutesToMidnight = Duration(
        hours: 23 - now.hour,
        minutes: 59 - now.minute,
        seconds: 59 - now.second,
      ).inMinutes;

      // Update if we're within an hour of midnight
      return minutesToMidnight < 60;
    }

    return false;
  }
}
