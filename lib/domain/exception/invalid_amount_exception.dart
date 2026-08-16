/// Exception thrown when a monetary amount violates the
/// financial rules defined by the Domain Layer.
///
/// [InvalidAmountException] represents a domain-level validation
/// failure related specifically to monetary values.
///
/// This exception can be thrown when an amount:
///
/// - Is `NaN`.
/// - Is infinite.
/// - Is negative when negative values are not allowed.
/// - Is zero when the business rule requires the amount to be
///   strictly greater than zero.
///
/// The actual validation is performed by [MoneyValidator].
/// This exception only represents and communicates the validation
/// failure to the upper layers of the application.
///
/// Example:
///
/// ```dart
/// throw const InvalidAmountException(
///   'Amount cannot be negative.',
/// );
/// ```
///
/// Keeping this exception inside the Domain Layer allows monetary
/// validation failures to be communicated without creating a
/// dependency on the Presentation Layer or any framework-specific
/// implementation.
final class InvalidAmountException implements Exception {
  /// A descriptive message explaining why the monetary amount
  /// was rejected by the Domain validation rules.
  ///
  /// The message should provide enough information for the
  /// upper layers to understand the reason for the validation failure.
  final String message;

  /// Creates an [InvalidAmountException] with the specified [message].
  ///
  /// The constructor is constant because the exception contains
  /// immutable data and does not require runtime initialization.
  const InvalidAmountException(this.message);

  /// Returns the exception message as the String representation
  /// of this exception.
  ///
  /// This makes the exception convenient to use for logging,
  /// debugging, and error handling.
  @override
  String toString() => message;
}
