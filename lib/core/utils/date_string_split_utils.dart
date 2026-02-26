import 'package:nepali_utils/nepali_utils.dart';

class DateTimeUtils {
  /// Full date & time
  static String formatFullDateTime(DateTime dateTime) {
    final nepaliDate = NepaliDateTime.fromDateTime(dateTime.toLocal());
    return NepaliDateFormat('EEEE, MMMM d, yyyy • hh:mm a').format(nepaliDate);
  }

  /// Date & time (no day)
  static String formatDateTimeNoDay(DateTime dateTime) {
    final nepaliDate = NepaliDateTime.fromDateTime(dateTime.toLocal());
    return NepaliDateFormat('MMMM d, yyyy • hh:mm a').format(nepaliDate);
  }

  /// Day name
  static String getDay(DateTime dateTime) {
    final nepaliDate = NepaliDateTime.fromDateTime(dateTime.toLocal());
    return NepaliDateFormat('EEEE').format(nepaliDate);
  }

  /// Time only (12-hour)
  static String formatTime12h(DateTime dateTime) {
    final nepaliDate = NepaliDateTime.fromDateTime(dateTime.toLocal());
    return NepaliDateFormat('hh:mm a').format(nepaliDate);
  }

  /// Date only
  static String formatDate(DateTime dateTime) {
    final nepaliDate = NepaliDateTime.fromDateTime(dateTime.toLocal());
    return NepaliDateFormat('MMMM d, yyyy').format(nepaliDate);
  }

  /// Format Date explicitly (e.g. yyyy-MM-dd)
  static String formatDatePattern(DateTime dateTime, String pattern) {
    final nepaliDate = NepaliDateTime.fromDateTime(dateTime.toLocal());
    return NepaliDateFormat(pattern).format(nepaliDate);
  }
}
