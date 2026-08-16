import 'package:finora/domain/exception/empty_value_exception.dart';
import 'package:finora/domain/exception/invalid_format_exception.dart';

/// Provides domain-level validation rules for usernames.
///
/// [UserNameValidator] is responsible for enforcing all business rules
/// related to the format and validity of a username.
///
/// This validator belongs to the Domain Layer because username validation
/// is a business rule and should not depend on any presentation or
/// framework-specific code.
///
/// The validator ensures that a username:
///
/// - Is not null or empty after trimming whitespace.
/// - Contains between 3 and 12 English letters as the name part.
/// - Contains exactly one supported separator: `@`, `_`, or `-`.
/// - Ends with between 1 and 10 numeric digits.
///
/// Expected format:
///
/// ```text
/// 3-12 letters + separator + 1-10 digits
/// ```
///
/// Examples of valid usernames:
///
/// ```text
/// marco@123
/// adam_7
/// john-987654
/// ```
///
/// Examples of invalid usernames:
///
/// ```text
/// ma@123          // Less than 3 letters
/// marco@          // Missing digits
/// marco@12345678901 // More than 10 digits
/// marco#123       // Unsupported separator
/// marco123        // Missing separator
/// ```
///
/// The validator follows a fail-fast approach:
/// if the value violates any domain rule, a specific domain exception
/// is thrown immediately.
///
/// This keeps validation logic centralized and prevents different parts
/// of the application from implementing the username rules differently.
abstract final class UserNameValidator {
  /// Regular expression that defines the valid username format.
  ///
  /// The expression enforces the following structure:
  ///
  /// ```text
  /// ^              → Start of the string
  /// [A-Za-z]{3,12} → 3 to 12 English letters
  /// [@_-]          → Exactly one supported separator
  /// \d{1,10}       → 1 to 10 digits
  /// $              → End of the string
  /// ```
  ///
  /// Therefore, the complete username must match the expected
  /// domain-defined format from beginning to end.
  static final RegExp _regex = RegExp(r'^[A-Za-z]{3,12}[@_-]\d{1,10}$');

  /// Validates a username and returns the cleaned value.
  ///
  /// The [userName] is trimmed before validation to remove unnecessary
  /// leading and trailing whitespace.
  ///
  /// Validation is performed in two main stages:
  ///
  /// 1. Check whether the username is empty.
  /// 2. Check whether the username follows the required format.
  ///
  /// If the value is empty, [EmptyValueException] is thrown.
  ///
  /// If the value does not match the required format,
  /// [InvalidFormatException] is thrown.
  ///
  /// If all validation rules pass successfully, the trimmed username
  /// is returned.
  ///
  /// Example:
  /// ```dart
  /// final userName =
  ///     UserNameValidator.validateOrThrow('  marco@123  ');
  ///
  /// print(userName); // marco@123
  /// ```
  static String validateOrThrow(String userName) {
    // Remove unnecessary whitespace from the beginning and end
    // of the provided username before performing validation.
    final trimmedUserName = userName.trim();

    // Reject empty usernames.
    //
    // This check is performed separately so that the caller receives
    // a specific exception describing the actual domain violation.
    if (trimmedUserName.isEmpty) {
      throw const EmptyValueException("UserName can't be empty.");
    }

    // Validate the username against the domain-defined format.
    //
    // If the username does not match the regular expression,
    // the value is considered invalid and cannot enter the Domain
    // in its current form.
    if (!_regex.hasMatch(trimmedUserName)) {
      throw const InvalidFormatException(
        'Invalid username format. '
        'Expected: 3-12 letters + (@ or _ or -) + 1-10 digits.',
      );
    }

    // Return the cleaned and validated username.
    //
    // At this point, the value has successfully passed all
    // username domain rules.
    return trimmedUserName;
  }
}
