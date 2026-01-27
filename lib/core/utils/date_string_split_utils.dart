import 'package:intl/intl.dart';

class DateTimeUtils {
  /// Full date & time → Tuesday, January 27, 2026 • 08:33 AM
  static String formatFullDateTime(DateTime dateTime) {
    return DateFormat(
      'EEEE, MMMM d, yyyy • hh:mm a',
    ).format(dateTime.toLocal());
  }

  /// Date & time (no day) → January 27, 2026 • 08:33 AM
  static String formatDateTimeNoDay(DateTime dateTime) {
    return DateFormat('MMMM d, yyyy • hh:mm a').format(dateTime.toLocal());
  }

  /// Day name → Monday
  static String getDay(DateTime dateTime) {
    return DateFormat('EEEE').format(dateTime.toLocal());
  }

  /// Time only → 08:33 AM
  static String formatTime12h(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime.toLocal());
  }

  /// Date only → January 27, 2026
  static String formatDate(DateTime dateTime) {
    return DateFormat('MMMM d, yyyy').format(dateTime.toLocal());
  }
}
