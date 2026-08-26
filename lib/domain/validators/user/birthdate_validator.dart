import 'package:finora/domain/exception/user/empty_value_exception.dart';
import 'package:finora/domain/exception/user/invalid_birthdate_exception.dart';

/// Validates a user's birth date according to the Domain business rules.
///
/// [BirthdateValidator] is responsible for validating the user's
/// date of birth before it is accepted by the Domain.
///
/// The validator guarantees that:
///
/// - A birth date must be provided.
/// - The birth date cannot be in the future.
/// - The user's age must be between 16 and 90 years old.
///
/// This class belongs to the Domain layer because these rules are
/// business rules, not UI-specific validation rules.
///
/// Validation flow:
///
/// ```text
/// DateTime?
///    │
///    ▼
/// Null Check
///    │
///    ├── null ──────────────► EmptyValueException
///    │
///    ▼
/// Future Date Check
///    │
///    ├── future date ───────► InvalidBirthdateException
///    │
///    ▼
/// Calculate Age
///    │
///    ▼
/// Age Range Check
///    │
///    ├── age < 16 ──────────► InvalidBirthdateException
///    ├── age > 90 ──────────► InvalidBirthdateException
///    │
///    ▼
/// Valid DateTime
/// ```
abstract final class BirthdateValidator {
  /// Validates the provided birth date and returns it when valid.
  ///
  /// [date] represents the user's date of birth.
  ///
  /// Throws:
  ///
  /// - [EmptyValueException] if [date] is null.
  /// - [InvalidBirthdateException] if the date is in the future.
  /// - [InvalidBirthdateException] if the calculated age is
  ///   outside the allowed range of 16 to 90 years.
  ///
  /// The method follows the `validateOrThrow` naming convention,
  /// meaning that invalid values are rejected by throwing a
  /// Domain-specific exception rather than returning a boolean.
  static DateTime validateOrThrow(DateTime? date) {
    // A birth date is required by the Domain.
    //
    // We reject null before performing any other operation
    // on the DateTime value.
    if (date == null) {
      throw EmptyValueException("The birthday date must not be empty.");
    }

    // Capture the current date and time once.
    //
    // This value is used as the reference point for both
    // future-date validation and age calculation.
    final now = DateTime.now();

    // A person's birth date cannot exist in the future.
    //
    // For example:
    //
    // Current date: 2026
    // Birth date:   2030
    //
    // Such a date is logically invalid.
    if (date.isAfter(now)) {
      throw InvalidBirthdateException(message: "Unbelievable birthday date.");
    }

    // Calculate the user's actual age.
    //
    // Simply calculating:
    //
    //     now.year - date.year
    //
    // is not always correct because the user's birthday may not
    // have occurred yet during the current year.
    //
    // Therefore, if the current date is before the birthday
    // in the current year, we subtract one from the calculated age.
    final age =
        now.year -
        date.year -
        ((now.month < date.month ||
                (now.month == date.month && now.day < date.day))
            ? 1
            : 0);

    // Apply the Domain's age business rule.
    //
    // Valid users must be at least 16 years old
    // and no older than 90 years old.
    //
    // Valid range:
    //
    //     16 <= age <= 90
    //
    // Invalid examples:
    //
    //     age = 15  ❌
    //     age = 16  ✅
    //     age = 30  ✅
    //     age = 90  ✅
    //     age = 91  ❌
    if (age < 16 || age > 90) {
      throw InvalidBirthdateException(
        message: "Your age must be more than or equal 16,and less than 90.",
      );
    }

    // The date has passed all Domain validation rules.
    //
    // Returning the original value allows the caller,
    // such as BirthdayDate, to safely use it.
    return date;
  }
}
