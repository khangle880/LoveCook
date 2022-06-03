import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String format([String? newPattern, String? locale]) {
    return DateFormat(newPattern, locale).format(this);
  }

  int get weekOfMonth {
    var wom = 0;
    var date = this;

    while (date.month == month) {
      wom++;
      date = date.subtract(const Duration(days: 7));
    }

    return wom;
  }

  bool isSameDay(DateTime targeDate) {
    return this.year == targeDate.year &&
        this.month == targeDate.month &&
        this.day == targeDate.day;
  }
}
