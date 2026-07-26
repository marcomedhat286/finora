import 'package:finora/domain/exception/empty_value_exception.dart';
import 'package:finora/domain/exception/invalid_format_exception.dart';
import 'package:finora/domain/Extensions/string_validate.dart';

/// Utility responsible for validating and normalizing personal names
/// according to the application's business rules.
///
/// A valid name must satisfy all of the following conditions:
///
/// - Not be `null`.
/// - Not be empty or consist only of whitespace.
/// - Contain only English alphabetic characters (`A-Z`, `a-z`).
/// - Have a length between **3** and **12** characters after trimming.
///
/// Examples of valid names:
///
/// ```text
/// Marco
/// Adam
/// John
/// Alice
/// ```
///
/// Examples of invalid names:
///
/// ```text
/// ""          // Empty.
/// "   "       // Whitespace only.
/// "Ma"        // Too short.
/// "Marco123"  // Contains digits.
/// "John_Doe"  // Contains unsupported characters.
/// ```
///
/// Besides validation, this class also normalizes the input by removing
/// leading and trailing whitespace before returning the validated value.
///
/// Invalid input is rejected immediately by throwing domain-specific
/// exceptions, preventing invalid data from entering the Domain layer.
abstract final class NameValidator {
  /// Regular expression describing the accepted name format.
  ///
  /// Pattern:
  ///
  /// - `^` → Start of the string.
  /// - `[A-Za-z]{3,12}` → 3–12 English alphabetic characters.
  /// - `$` → End of the string.
  static final RegExp _regExpName = RegExp(r'^[A-Za-z]{3,12}$');

  /// Validates and normalizes the supplied name.
  ///
  /// Validation workflow:
  ///
  /// 1. Ensure the value is not `null` or empty.
  /// 2. Remove leading and trailing whitespace.
  /// 3. Verify that the normalized value satisfies the required format.
  /// 4. Return the normalized value.
  ///
  /// Parameters:
  ///
  /// - [name] The value to validate.
  /// - [nameType] Optional label used to produce more meaningful
  ///   validation error messages.
  ///
  /// Returns:
  ///
  /// The validated and trimmed name.
  ///
  /// Throws:
  ///
  /// - [EmptyValueException] if the supplied value is `null`,
  ///   empty, or whitespace-only.
  /// - [InvalidFormatException] if the normalized value
  ///   violates the required business rules.
  static String validateOrThrow({
    required String? name,
    String nameType = "name",
  }) {
    /// Reject null, empty, or whitespace-only values before
    /// performing any additional validation.
    if (name.isNullOrEmpty) {
      throw EmptyValueException("The $nameType must not be empty.");
    }

    /// Normalize the input by removing leading and trailing whitespace.
    ///
    /// Returning the trimmed value guarantees that callers always
    /// receive a clean, validated name.
    final trimmedName = name!.trim();

    /// Ensure the normalized value satisfies the required
    /// business constraints.
    if (!trimmedName.isValid(_regExpName)) {
      throw InvalidFormatException(
        "The $nameType must contain only letters (3-12 characters).",
      );
    }

    /// Return the validated, normalized value.
    return trimmedName;
  }
}
