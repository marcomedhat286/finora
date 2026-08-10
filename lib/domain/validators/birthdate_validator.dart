import 'package:finora/domain/exception/empty_value_exception.dart';
import 'package:finora/domain/exception/invalid_birthdate_exception.dart';

abstract final class BirthdateValidator {
  static DateTime validateOrThrow(DateTime? date) {
    if (date == null) {
      throw EmptyValueException("The birthday date must not be empty.");
    }
    final now = DateTime.now();
    if (date.isAfter(now)) {
      throw InvalidBirthdateException(message: "Unbelievable birthday date.");
    }
    final age =
        now.year -
        date.year -
        ((now.month < date.month ||
                (now.month == date.month && now.day < date.day))
            ? 1
            : 0);

    if (age <= 16) {
      throw InvalidBirthdateException(
        message: "Your age must be more than or equal 16.",
      );
    }
    return date;
  }
}
