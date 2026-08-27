import 'package:finora/domain/exception/user/empty_value_exception.dart';
import 'package:finora/domain/exception/user/invalid_format_exception.dart';

/// Validates transaction identifiers according to the domain rules.
///
/// [TransactionIdValidator] is responsible only for validating and cleaning
/// raw transaction ID values before they are wrapped inside the
/// [TransactionId] value object.
///
/// A valid transaction ID must:
/// - Not be empty.
/// - Start with the `tx_` prefix.
/// - Follow the UUID v4 format.
/// - Contain a valid UUID version and variant.
///
/// Example of a valid transaction ID:
/// `tx_550e8400-e29b-41d4-a716-446655440000`
///
/// This class contains only static validation logic, so it cannot be
/// instantiated.
abstract final class TransactionIdValidator {
  /// Regular expression used to validate the complete transaction ID format.
  ///
  /// The expected structure is:
  ///
  /// `tx_` + UUID v4
  ///
  /// UUID v4 itself follows this structure:
  ///
  /// `xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx`
  ///
  /// Where:
  /// - `4` identifies UUID version 4.
  /// - `[89abAB]` identifies the valid UUID variant.
  /// - The remaining characters are hexadecimal digits.
  static final RegExp _transactionIdRegex = RegExp(
    r'^tx_[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-4[0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$',
  );

  /// Validates a raw transaction ID and returns its cleaned value.
  ///
  /// The validation process is:
  ///
  /// 1. Remove unnecessary whitespace from the beginning and end.
  /// 2. Ensure the resulting ID is not empty.
  /// 3. Verify that the ID matches the required transaction ID format.
  /// 4. Return the trimmed and validated identifier.
  ///
  /// Throws:
  /// - [EmptyValueException] when the transaction ID is empty.
  /// - [InvalidFormatException] when the transaction ID does not match
  ///   the required format.
  static String validateOrThrow(String transactionId) {
    // Remove accidental whitespace entered around the transaction ID.
    final trimmedTransactionId = transactionId.trim();

    // An empty identifier cannot represent a valid transaction identity.
    if (trimmedTransactionId.isEmpty) {
      throw const EmptyValueException("Transaction ID must not be empty.");
    }

    // Ensure the identifier follows the required `tx_` + UUID v4 format.
    if (!_transactionIdRegex.hasMatch(trimmedTransactionId)) {
      throw const InvalidFormatException("Invalid transaction ID format");
    }

    // Return the cleaned value so the Value Object does not need to
    // perform the same trimming operation again.
    return trimmedTransactionId;
  }
}
