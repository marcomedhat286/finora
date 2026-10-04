import 'package:finora/domain/enum/transaction/date_range_options.dart';
import 'package:finora/domain/value_object/transaction/date_range.dart';

abstract final class DateRangeCalculator {
  static DateRange? calculate({
    required DateRangeOptions option,
    DateRange? range,
  }) {
    final now = DateTime.now();

    switch (option) {
      case DateRangeOptions.anyDate:
        return null;

      case DateRangeOptions.last7Days:
        return DateRange.create(
          from: now.subtract(const Duration(days: 7)),
          to: now,
        );

      case DateRangeOptions.last14Days:
        return DateRange.create(
          from: now.subtract(const Duration(days: 14)),
          to: now,
        );

      case DateRangeOptions.thisMonth:
        return DateRange.create(
          from: DateTime(now.year, now.month, 1),
          to: now,
        );

      case DateRangeOptions.lastMonth:
        return DateRange.create(
          from: DateTime(now.year, now.month - 1, 1),
          to: DateTime(now.year, now.month, 0),
        );

      case DateRangeOptions.customRange:
        if (range == null) {
          throw StateError("the range must be entered");
        } else {
          return range;
        }
    }
  }
}
