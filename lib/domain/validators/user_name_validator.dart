import 'package:finora/domain/exception/empty_value_exception.dart';
import 'package:finora/domain/exception/invalid_format_exception.dart';

///                       14/7
/// Utility class responsible for validating usernames according to
/// Finora's business rules.
///
/// A valid username must satisfy **all** of the following conditions:
///
/// - Begin with **3 to 12 English alphabetic characters**.
/// - Contain **exactly one** separator:
///   - `@`
///   - `_`
///   - `-`
/// - End with a numeric suffix containing **1 to 10 digits**.
///
/// Examples of valid usernames:
///
/// ```text
/// marco@123
/// adam_7
/// john-987654
/// alice@0001
/// ```
///
/// Examples of invalid usernames:
///
/// ```text
/// ma@123          // Name is shorter than 3 characters.
/// marco123        // Missing separator.
/// marco@@123      // More than one separator.
/// marco-          // Missing numeric suffix.
/// marco_12345678901 // Numeric suffix exceeds 10 digits.
/// ```
///
/// This validator throws domain-specific exceptions instead of returning
/// boolean values, allowing the caller to react with meaningful
/// error messages.
abstract final class UserNameValidator {
  /// Regular expression that defines the accepted username format.
  ///
  /// Pattern breakdown:
  ///
  /// - `^` → Start of the string.
  /// - `[A-Za-z]{3,12}` → Name consisting of 3–12 English letters.
  /// - `[@_-]` → Exactly one supported separator.
  /// - `\d{1,10}` → Numeric suffix containing 1–10 digits.
  /// - `$` → End of the string.
  ///
  /// Using a single regular expression guarantees that the entire
  /// username complies with all formatting rules.
  static final RegExp _regex = RegExp(r'^[A-Za-z]{3,12}[@_-]\d{1,10}$');

  /// Validates the supplied username.
  ///
  /// Validation is performed in two stages:
  ///
  /// 1. Ensure the username is not empty or whitespace-only.
  /// 2. Verify that it matches the required username format.
  ///
  /// Throws:
  ///
  /// - [EmptyValueException] if the username is empty after trimming
  ///   leading and trailing whitespace.
  /// - [InvalidFormatException] if the username violates any formatting
  ///   rule defined by [_regex].
  static void validateOrThrow(String userName) {
    /// Reject usernames that contain no meaningful characters.
    ///
    /// Calling `trim()` removes leading and trailing whitespace,
    /// preventing values such as `"   "` from being considered valid.
    if (userName.trim().isEmpty) {
      throw const EmptyValueException("UserName can't be empty.");
    }

    /// Ensure the username matches the required business rules.
    ///
    /// If the format is invalid, a domain-specific exception is thrown
    /// so the caller can display an appropriate validation message.
    if (!_regex.hasMatch(userName)) {
      throw const InvalidFormatException(
        "Invalid username format. Expected: 3-12 letters + (@ or _ or -) + 1-10 digits.",
      );
    }
  }
}
