import 'package:finora/domain/exception/user/invalid_date_time_exception.dart';
import 'package:finora/domain/validators/user/validate_date.dart';

abstract final class DateRangeValidator {
  static void validateOrThrow({
    required DateTime? from,
    required DateTime? to,
  }) {
    if (from == null || to == null) return;
    CreatedAtValidator.validateOrThrow(time: from);
    CreatedAtValidator.validateOrThrow(time: to);
    if (from.isAfter(to)) {
      throw InvalidDateTimeException(
        "Is not valid that from date is after date.",
      );
    }
  }
}
