import 'package:finora/domain/exception/empty_value_exception.dart';
import 'package:finora/domain/exception/invalid_account_name_length_exception.dart';

/// Provides domain-level validation rules for account names.
///
/// [AccountNameValidator] ensures that an account name satisfies
/// the business constraints defined by the Domain Layer.
///
/// The validator enforces the following rules:
///
/// - The account name must not be empty.
/// - Leading and trailing whitespace is removed before validation.
/// - The account name must contain at least [minLength] characters.
/// - The account name must not exceed [maxLength] characters.
///
/// Current rules:
///
/// ```text
/// Minimum length: 2 characters
/// Maximum length: 30 characters
/// ```
///
/// If the provided value violates any of these rules, an appropriate
/// Domain exception is thrown.
///
/// This validator is intentionally kept separate from [AccountName]
/// so that the Value Object is responsible for representing the value,
/// while this class is responsible for enforcing its validation rules.
///
/// [AccountNameValidator] is stateless and therefore exposes its
/// validation behavior through a static method.
abstract final class AccountNameValidator {
  /// Minimum number of characters allowed for an account name.
  ///
  /// Any account name shorter than this value is considered invalid.
  static const int minLength = 2;

  /// Maximum number of characters allowed for an account name.
  ///
  /// Any account name longer than this value is considered invalid.
  static const int maxLength = 30;

  /// Validates an account name and returns its cleaned value.
  ///
  /// The provided [rawValue] is trimmed before validation so that
  /// unnecessary leading and trailing whitespace does not affect
  /// the validation result.
  ///
  /// Validation is performed in the following order:
  ///
  /// 1. Trim leading and trailing whitespace.
  /// 2. Check whether the value is empty.
  /// 3. Check whether its length is within the allowed range.
  /// 4. Return the cleaned and validated value.
  ///
  /// Throws [EmptyValueException] when the account name is empty.
  ///
  /// Throws [InvalidAccountNameLengthException] when the account
  /// name is shorter than [minLength] or longer than [maxLength].
  ///
  /// Example:
  ///
  /// ```dart
  /// final name = AccountNameValidator.validateOrThrow(
  ///   'My Savings',
  /// );
  ///
  /// print(name); // My Savings
  /// ```
  static String validateOrThrow(String rawValue) {
    // Remove leading and trailing whitespace before performing
    // any validation.
    final trimmedValue = rawValue.trim();

    // Reject empty account names because an account must have
    // a meaningful name.
    if (trimmedValue.isEmpty) {
      throw const EmptyValueException('The account name must not be empty.');
    }

    // Ensure that the account name length is within the
    // business-defined minimum and maximum limits.
    //
    // A dedicated exception is thrown so the caller can know
    // that the failure is specifically related to the name length.
    if (trimmedValue.length < minLength || trimmedValue.length > maxLength) {
      throw InvalidAccountNameLengthException(
        currentLength: trimmedValue.length,
        minLength: minLength,
        maxLength: maxLength,
      );
    }

    // Return the cleaned and validated account name.
    //
    // At this point, the value has successfully passed all
    // AccountName validation rules.
    return trimmedValue;
  }
}
