import 'package:finora/domain/exception/empty_value_exception.dart';
import 'package:finora/domain/exception/invalid_format_exception.dart';

///                                15/7
/// Utility responsible for validating and normalizing account identifiers
/// according to the application's business rules.
///
/// A valid account identifier must:
///
/// - Not be empty or contain only whitespace.
/// - Begin with the constant prefix `acc_`.
/// - End with a numeric suffix containing **1** to **10** digits.
///
/// Examples of valid account IDs:
///
/// ```text
/// acc_7
/// acc_123
/// acc_000987
/// acc_1234567890
/// ```
///
/// Examples of invalid account IDs:
///
/// ```text
/// ""
/// "   "
/// acc_
/// account_123
/// acc_123abc
/// ACC_123
/// ```
///
/// Besides validation, this class also normalizes the supplied value
/// by removing leading and trailing whitespace before returning it.
///
/// Invalid values are rejected immediately through domain-specific
/// exceptions, preventing malformed account identifiers from
/// entering the Domain layer.
abstract final class AccountIdValidator {
  /// Regular expression describing the accepted account ID format.
  ///
  /// Pattern:
  ///
  /// - `^` → Start of the string.
  /// - `acc_` → Required account identifier prefix.
  /// - `\d{1,10}` → Numeric suffix containing 1–10 digits.
  /// - `$` → End of the string.
  static final RegExp _accountIdRegex = RegExp(r'^acc_(\d{1,10})$');

  /// Validates and normalizes the supplied account identifier.
  ///
  /// Validation workflow:
  ///
  /// 1. Remove leading and trailing whitespace.
  /// 2. Ensure the value is not empty.
  /// 3. Verify that it matches the required account ID format.
  /// 4. Return the normalized value.
  ///
  /// Returns:
  ///
  /// The validated and normalized account identifier.
  ///
  /// Throws:
  ///
  /// - [EmptyValueException] if the supplied value is empty
  ///   after trimming.
  /// - [InvalidFormatException] if the supplied value
  ///   violates the required account ID format.
  static String validateOrThrow(String accountId) {
    /// Normalize the supplied value before validation.
    final trimmedAccountId = accountId.trim();

    /// Reject empty or whitespace-only values.
    if (trimmedAccountId.isEmpty) {
      throw const EmptyValueException("Account ID must not be empty.");
    }

    /// Ensure the normalized value satisfies the required
    /// account identifier format.
    if (!_accountIdRegex.hasMatch(trimmedAccountId)) {
      throw const InvalidFormatException(
        "Invalid account ID format. Expected: acc_<1-10 digits>.",
      );
    }

    /// Return the validated and normalized account identifier.
    return trimmedAccountId;
  }
}
