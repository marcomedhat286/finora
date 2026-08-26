import 'package:finora/domain/exception/user/empty_value_exception.dart';
import 'package:finora/domain/exception/user/invalid_format_exception.dart';

/// Validates usernames according to the Domain rules of the application.
///
/// [UserNameValidator] is responsible for ensuring that every username
/// entering the Domain follows the required format and contains a valid
/// value.
///
/// The validator performs two main checks:
///
/// 1. Ensures that the username is not empty.
/// 2. Ensures that the username follows the required format.
///
/// Supported username format:
///
/// ```text
/// 3-12 English letters
///        ↓
///    @ / _ / -
///        ↓
///  1-10 digits
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
/// marco123        // Missing separator
/// marco#123       // Invalid separator
/// marco@12345678901 // More than 10 digits
/// ```
///
/// This class contains only static validation logic and does not need
/// to be instantiated.
abstract final class UserNameValidator {
  /// Regular expression defining the valid username format.
  ///
  /// Breakdown:
  ///
  /// ```text
  /// ^            → Start of the string
  /// [A-Za-z]{3,12}
  ///              → 3 to 12 English letters
  /// [@_-]        → Exactly one allowed separator
  /// \d{1,10}     → 1 to 10 digits
  /// $            → End of the string
  /// ```
  ///
  /// Therefore, the complete username must contain nothing more and
  /// nothing less than the defined structure.
  static final RegExp _regex = RegExp(r'^[A-Za-z]{3,12}[@_-]\d{1,10}$');

  /// Validates a username and returns its normalized value.
  ///
  /// The input is first trimmed to remove unnecessary whitespace
  /// from the beginning and end of the username.
  ///
  /// If the resulting value is empty, [EmptyValueException] is thrown.
  ///
  /// If the username does not match [_regex],
  /// [InvalidFormatException] is thrown.
  ///
  /// When validation succeeds, the trimmed username is returned.
  ///
  /// This method follows the `validateOrThrow` convention:
  ///
  /// ```text
  /// Valid input
  ///     ↓
  /// Return cleaned value
  ///
  /// Invalid input
  ///     ↓
  /// Throw Domain Exception
  /// ```
  static String validateOrThrow(String userName) {
    // Remove unnecessary whitespace before applying the Domain rules.
    //
    // This prevents values such as:
    //
    // "   marco@123   "
    //
    // from being stored with unwanted surrounding spaces.
    final trimmedUserName = userName.trim();

    // An empty username is considered invalid.
    //
    // This check is performed separately from the format validation
    // so the caller receives a meaningful Domain exception describing
    // the actual problem.
    if (trimmedUserName.isEmpty) {
      throw const EmptyValueException("UserName can't be empty.");
    }

    // Verify that the username follows the required Domain format.
    //
    // Any username that does not match the regular expression is
    // rejected before it can enter the Domain as a UserName Value Object.
    if (!_regex.hasMatch(trimmedUserName)) {
      throw const InvalidFormatException(
        'Invalid username format. '
        'Expected: 3-12 letters + (@ or _ or -) + 1-10 digits.',
      );
    }

    // Return the validated and normalized username.
    return trimmedUserName;
  }
}
