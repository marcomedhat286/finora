import 'package:finora/domain/exception/empty_value_exception.dart';
import 'package:finora/domain/exception/invalid_format_exception.dart';

/// Provides domain-level validation rules for account identifiers.
///
/// [AccountIdValidator] is responsible for ensuring that an account ID
/// follows the exact format required by the Domain Layer.
///
/// The expected Account ID format is:
///
/// ```text
/// acc_<UUID v4>
/// ```
///
/// Example of a valid Account ID:
///
/// ```text
/// acc_550e8400-e29b-41d4-a716-446655440000
/// ```
///
/// The validator enforces the following rules:
///
/// - The Account ID must not be empty.
/// - Leading and trailing whitespace is removed before validation.
/// - The identifier must start with the `acc_` prefix.
/// - The remaining identifier must follow the UUID v4 format.
/// - The UUID must contain the correct number of hexadecimal characters
///   and hyphens.
/// - The UUID version must be `4`.
/// - The UUID variant must be one of the valid RFC 4122 variants.
///
/// If any rule is violated, an appropriate Domain exception is thrown.
///
/// This class belongs to the Domain Layer because the Account ID format
/// is part of the application's domain rules and should not depend on
/// the Presentation or Data Layer.
///
/// [AccountIdValidator] is stateless and therefore exposes its validation
/// behavior through a static method.
abstract final class AccountIdValidator {
  /// Regular expression that defines the valid Account ID format.
  ///
  /// The expected structure is:
  ///
  /// ```text
  /// acc_<UUID v4>
  /// ```
  ///
  /// The UUID itself follows this structure:
  ///
  /// ```text
  /// xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx
  /// ```
  ///
  /// Where:
  ///
  /// - `xxxxxxxx` represents hexadecimal characters.
  /// - The third UUID group starts with `4`, identifying UUID version 4.
  /// - The fourth UUID group starts with `8`, `9`, `A`, `B`, `a`, or `b`,
  ///   identifying a valid UUID variant.
  /// - The remaining characters are hexadecimal.
  ///
  /// The `^` and `$` anchors ensure that the entire string must match
  /// the expected format.
  static final RegExp _uuidRegex = RegExp(
    r'^acc_[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-4[0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$',
  );

  /// Validates an Account ID and returns its cleaned value.
  ///
  /// The provided [accountId] is trimmed before validation to remove
  /// unnecessary leading and trailing whitespace.
  ///
  /// Validation is performed in the following order:
  ///
  /// 1. Check whether the Account ID is empty.
  /// 2. Check whether the Account ID matches the required UUID v4 format.
  /// 3. Return the trimmed and validated identifier.
  ///
  /// Throws [EmptyValueException] when the provided Account ID is empty.
  ///
  /// Throws [InvalidFormatException] when the Account ID does not match
  /// the required `acc_<UUID v4>` format.
  ///
  /// Example:
  ///
  /// ```dart
  /// final accountId = AccountIdValidator.validateOrThrow(
  ///   'acc_550e8400-e29b-41d4-a716-446655440000',
  /// );
  ///
  /// print(accountId);
  /// // acc_550e8400-e29b-41d4-a716-446655440000
  /// ```
  static String validateOrThrow(String accountId) {
    // Remove leading and trailing whitespace before performing
    // validation.
    final trimmedAccountId = accountId.trim();

    // Reject empty Account IDs.
    //
    // This check is performed separately so the caller receives
    // a specific exception describing the actual validation failure.
    if (trimmedAccountId.isEmpty) {
      throw const EmptyValueException('Account ID must not be empty.');
    }

    // Validate the complete Account ID against the required
    // `acc_<UUID v4>` format.
    //
    // If the value does not match the regular expression, it cannot
    // be represented as a valid AccountId inside the Domain.
    if (!_uuidRegex.hasMatch(trimmedAccountId)) {
      throw InvalidFormatException(
        'Invalid Account ID format: $trimmedAccountId',
      );
    }

    // Return the cleaned and validated Account ID.
    //
    // At this point, the value has successfully passed all
    // Account ID domain rules.
    return trimmedAccountId;
  }
}
