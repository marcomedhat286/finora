/// Exception thrown when an account type code is not supported
/// by the Domain.
///
/// [InvalidAccountTypeException] represents a Domain-level validation
/// failure that occurs when an external or persisted account type code
/// does not match any of the values defined in [AccountType].
///
/// The exception preserves the original invalid code through
/// [invalidCode], allowing upper layers to inspect the exact value
/// that caused the validation failure.
///
/// Example:
///
/// ```dart
/// throw InvalidAccountTypeException('crypto');
/// ```
///
/// The generated message will be:
///
/// ```text
/// The account type code "crypto" is not supported.
/// ```
///
/// This exception is typically thrown by [AccountTypeValidator]
/// when it cannot map a provided code to a valid [AccountType].
final class InvalidAccountTypeException implements Exception {
  /// The account type code that failed validation.
  ///
  /// This preserves the original input so that upper layers can
  /// inspect, log, or handle the invalid value when necessary.
  final String invalidCode;

  /// A human-readable description of the validation failure.
  ///
  /// The message is generated automatically from [invalidCode].
  final String message;

  /// Creates an [InvalidAccountTypeException] for an unsupported
  /// account type [invalidCode].
  ///
  /// The error message is generated automatically to clearly identify
  /// the unsupported code.
  InvalidAccountTypeException(this.invalidCode)
    : message = 'The account type code "$invalidCode" is not supported.';

  /// Returns the generated error message as the String representation
  /// of this exception.
  ///
  /// This makes the exception convenient for logging, debugging,
  /// and handling by upper application layers.
  @override
  String toString() => message;
}
