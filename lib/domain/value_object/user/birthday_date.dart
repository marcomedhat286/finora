import 'package:finora/domain/validators/user/birthdate_validator.dart';

/// Represents a validated and immutable user's date of birth.
///
/// [BirthdayDate] is a Value Object responsible for representing
/// a user's birthday inside the Domain layer.
///
/// A [BirthdayDate] cannot be created directly from an arbitrary
/// [DateTime]. Every value must first pass through
/// [BirthdateValidator].
///
/// This guarantees that a [BirthdayDate] instance always contains
/// a date that satisfies the Domain's business rules.
///
/// The creation flow is:
///
/// ```text
/// Raw DateTime?
///      ↓
/// BirthdayDate.create()
///      ↓
/// BirthdateValidator
///      ↓
/// Valid Date
///      ↓
/// BirthdayDate
/// ```
///
/// The Value Object also provides useful domain-related operations
/// such as calculating the user's current age and formatting the
/// birthday for display.
///
/// Equality is based on the calendar date (year, month, and day),
/// not on the exact time stored inside the [DateTime].
class BirthdayDate {
  /// Stores the validated date of birth.
  ///
  /// The field is final, which makes the Value Object immutable
  /// after creation.
  final DateTime value;

  /// Private constructor used only after successful validation.
  ///
  /// Keeping this constructor private prevents external code from
  /// creating a [BirthdayDate] without going through
  /// [BirthdayDate.create].
  const BirthdayDate._({required this.value});

  /// Creates a validated [BirthdayDate] from a nullable [DateTime].
  ///
  /// The provided date is passed to [BirthdateValidator], which
  /// applies all Domain rules related to the user's birth date.
  ///
  /// If the date is invalid, the validator throws the appropriate
  /// Domain exception and the object is not created.
  factory BirthdayDate.create(DateTime? date) {
    // Validate the raw date before allowing it to enter the Domain.
    final validDate = BirthdateValidator.validateOrThrow(date);

    // Create the Value Object only after successful validation.
    return BirthdayDate._(value: validDate);
  }

  /// Calculates the user's current age based on the birthday.
  ///
  /// The calculation considers both the month and the day of birth.
  /// This is important because simply subtracting the birth year
  /// from the current year can produce an incorrect age before
  /// the user's birthday occurs in the current year.
  ///
  /// Example:
  ///
  /// ```text
  /// Birthday: 20/12/2000
  /// Today:    26/08/2026
  ///
  /// 2026 - 2000 = 26
  ///
  /// But the birthday has not occurred yet,
  /// so the actual age is 25.
  /// ```
  int get age {
    // Get the current date to calculate the user's current age.
    final now = DateTime.now();

    // Start by subtracting the birth year from the current year.
    //
    // If the birthday has not occurred yet this year,
    // subtract one additional year.
    return now.year -
        value.year -
        ((now.month < value.month ||
                (now.month == value.month && now.day < value.day))
            ? 1
            : 0);
  }

  /// Returns the birthday in a simple human-readable format.
  ///
  /// Example:
  ///
  /// ```text
  /// 26/8/2000
  /// ```
  ///
  /// This getter is useful when the birthday needs to be displayed
  /// in the Presentation layer.
  String get formattedDate => "${value.day}/${value.month}/${value.year}";

  /// Returns the birthday using the ISO-8601 DateTime representation.
  ///
  /// This representation is useful for logging, serialization,
  /// debugging, and communication with external layers.
  @override
  String toString() => value.toIso8601String();

  /// Determines whether two [BirthdayDate] objects represent
  /// the same calendar date.
  ///
  /// The comparison intentionally ignores the time portion of
  /// the [DateTime].
  ///
  /// Therefore, these two values are considered equal:
  ///
  /// ```text
  /// 2000-08-26 08:00
  /// 2000-08-26 20:30
  /// ```
  ///
  /// because both represent the same birthday:
  ///
  /// ```text
  /// 26/08/2000
  /// ```
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BirthdayDate &&
            other.value.year == value.year &&
            other.value.month == value.month &&
            other.value.day == value.day);
  }

  /// Generates a hash code based on the calendar date.
  ///
  /// The hash code uses the same fields used by [operator ==],
  /// ensuring that equal [BirthdayDate] objects always have the
  /// same hash code.
  @override
  int get hashCode => Object.hash(value.year, value.month, value.day);
}
