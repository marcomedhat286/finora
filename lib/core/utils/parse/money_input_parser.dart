import 'package:finora/domain/exception/empty_value_exception.dart';
import 'package:finora/domain/validators/invalid_double_format_exception.dart';

/// Parses raw monetary input from the Presentation Layer into a [double].
///
/// [MoneyInputParser] is a Presentation-layer helper responsible for
/// converting user-entered text into a numeric value before passing
/// it to the Domain Layer.
///
/// The parser performs input-level checks only:
///
/// 1. Removes leading and trailing whitespace.
/// 2. Ensures that the input is not empty.
/// 3. Attempts to parse the input as a [double].
/// 4. Throws a specific exception when the input cannot be converted
///    into a valid numeric representation.
/// 5. Returns the parsed numeric value when parsing succeeds.
///
/// This class is intentionally focused on parsing and does not contain
/// the actual business rules for monetary values.
///
/// For example, this class can convert:
///
/// ```text
/// "2000"   → 2000.0
/// "150.50" → 150.5
/// " 500 "  → 500.0
/// ```
///
/// However, rules such as whether negative amounts are allowed,
/// whether zero is allowed, or whether the amount is financially valid
/// belong to the Domain Layer and should be handled by [MoneyValidator].
///
/// This separation keeps input parsing separate from business validation.
class MoneyInputParser {
  /// Parses a String input into a [double].
  ///
  /// [value] represents the raw text entered by the user.
  ///
  /// [fieldName] identifies the input field and is included in
  /// validation error messages to make them more descriptive.
  ///
  /// The input is trimmed before parsing so that unnecessary
  /// leading or trailing whitespace does not cause parsing failures.
  ///
  /// Throws [EmptyValueException] when the trimmed input is empty.
  ///
  /// Throws [InvalidDoubleFormatException] when the input cannot
  /// be converted into a valid [double].
  ///
  /// Returns the parsed [double] when the input is valid.
  ///
  /// Example:
  ///
  /// ```dart
  /// final balance = MoneyInputParser.parseToDouble(
  ///   value: '1500.50',
  ///   fieldName: 'initial balance',
  /// );
  ///
  /// print(balance); // 1500.5
  /// ```
  static double parseToDouble({
    required String value,
    required String fieldName,
  }) {
    // Remove unnecessary whitespace before performing
    // any validation or parsing.
    final trimmedValue = value.trim();

    // Reject empty input because a monetary value is required
    // for this operation.
    if (trimmedValue.isEmpty) {
      throw EmptyValueException('The $fieldName must not be empty.');
    }

    // Attempt to convert the cleaned String into a double.
    //
    // tryParse is used instead of double.parse so invalid user input
    // can be handled gracefully without throwing Dart's FormatException.
    final parsedDouble = double.tryParse(trimmedValue);

    // If parsing fails, the input does not represent a valid
    // numeric value and cannot be converted into a monetary amount.
    if (parsedDouble == null) {
      throw InvalidDoubleFormatException(
        'The $fieldName must be a valid number '
        '(e.g., 2000 or 150.50).',
      );
    }

    // Return the successfully parsed numeric value.
    //
    // At this stage, the value has been successfully converted
    // from String to double, but it has not necessarily passed
    // the Domain's monetary business rules yet.
    return parsedDouble;
  }
}
