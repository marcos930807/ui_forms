import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeFormatConstants {
  static const iso8601WithMillisecondsOnly = 'yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'';
  static const defaultDateTimeFormat = 'EEEE, d MMM y';
  static const dMMMyyyyHHmmFormatID = 'd MMM yyyy, HH.mm';
  static const dMMMyyyyHHmmFormatEN = 'd MMM yyyy, HH:mm';
  static const dMMMyyyyFormat = 'd MMM yyyy';
  static const ddMMMyyyyFormat = 'dd MMM yyyy';
  static const dMMMMyyyyFormat = 'd MMMM yyyy';
  static const ddMMyyyyFormat = 'ddMMyyyy';
  static const mMMyyyyFormat = 'MMM yyyy';
  static const ddMMMFormat = 'd MMM';
  static const timeHHmmssFormatID = 'HH.mm.ss';
  static const timeHHmmssFormatEN = 'HH:mm:ss';
  static const timeHHmmFormatID = 'HH.mm';
  static const timeHHmmFormatEN = 'HH:mm';
  static const eEEEdMMMMyFormat = 'EEEE, d MMMM y';
  static const yyyyMMdd = 'yyyy-MM-dd';
  static const ddMMyyyy = 'dd-MM-yyyy';
  static const day = 'dd';
  static const weekday = 'EEEE';
  static const month = 'MMM';
  static const ddMMMMyyyy = 'dd MMMM yyyy';
  static const ddMMMyyyy = 'dd MMM yyyy';
  static const timeMMMMyyyy = 'MMMM yyyy';
  static const mmyy = 'MM/yy';
  static const timeSeparater = ':';
  static const String monthFull = 'MMMM';
  static const String year = 'y';

  static const timeBooking = 'HH:mm';
  static const hHddMMyyyy = 'dd/MM/yyyy';
}

/// Returns `date` in UTC format, without its time part.
DateTime normalizeDate(DateTime date) {
  return DateTime.utc(date.year, date.month, date.day);
}

/// Checks if two DateTime objects are the same day.
/// Returns `false` if either of them is null.
bool isSameDate(DateTime? a, DateTime? b) {
  if (a == null || b == null) {
    return false;
  }

  return a.year == b.year && a.month == b.month && a.day == b.day;
}

extension DateTimeX on DateTime {
  DateTime get normalize => normalizeDate(this);
}

extension DateFormatted on DateTime {
  DateTime oneMonthBeforeInSameYear() {
    final oneMonthBefore = subtract(const Duration(days: 31));
    if (oneMonthBefore.isBefore(
      DateTime(
        year,
      ),
    )) {
      return DateTime(
        year,
      );
    }
    return oneMonthBefore;
  }

  DateTime oneMonthBefore() {
    return subtract(const Duration(days: 31));
  }

  DateTime addDays(int days) {
    return add(Duration(days: days));
  }

  DateTime thisMonthAtInit() {
    return DateTime(
      year,
      month,
    );
  }

  DateTime thisMonthAtEnd() {
    return DateTime(year, month + 1, 0);
  }

  String get toFormattedDate {
    return DateFormat(
      'MMM d, h:mm a',
      Intl.getCurrentLocale(),
    ).format(this.toLocal());
  }

  String get toShortFormattedDate {
    return DateFormat(
      'EEE, MMM d y',
      Intl.getCurrentLocale(),
    ).format(this.toLocal());
  }

  String get toShortFormattedDateWithoutYear {
    return DateFormat(
      'EEE, MMM d',
      Intl.getCurrentLocale(),
    ).format(this.toLocal());
  }

  String get toPipeFormattedDateUTC {
    return DateFormat(
      'd/M/y',
      Intl.getCurrentLocale(),
    ).format(this);
  }

  String get toPipeFormattedDate2 {
    return DateFormat(
      'y-M-d',
      Intl.getCurrentLocale(),
    ).format(this.toLocal());
  }

  String get toPipeFormattedDateWithHours {
    return DateFormat(
      'd/M/y',
      Intl.getCurrentLocale(),
    ).add_jm().format(this.toLocal());
  }

  String get toFormattedMontYear {
    return DateFormat(
      'yMMMM',
      Intl.getCurrentLocale(),
    ).format(this.toLocal());
  }

  String get toFormattedDayMontYear {
    return DateFormat(
      'MMM d,y',
      Intl.getCurrentLocale(),
    ).format(this.toLocal());
  }
}

Future<DateTime?> selectDate(
  BuildContext context, {
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: firstDate ?? DateTime(2020),
    lastDate: lastDate ?? DateTime(2025),
  );
  if (picked != null) return picked;
  return null;
}

Future<DateTimeRange?> selectDateRange(
  BuildContext context, {
  DateTime? firstDate,
  DateTime? lastDate,
  DateTimeRange? initialDateRange,
}) async {
  // if (useFlutterOfficial) {
  //Flutter Now Support Officially DateRange Picker
  final DateTimeRange? picked = await showDateRangePicker(
    context: context,
    firstDate: firstDate ?? DateTime(2020),
    lastDate: lastDate ?? DateTime(2035),
    initialDateRange: initialDateRange,
    builder: (context, Widget? child) => Theme(
      data: Theme.of(context).copyWith(
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              backgroundColor: Theme.of(context).primaryColor,
            ),
      ),
      child: child!,
    ),
  );
  if (picked != null) return picked;
  return null;
}
