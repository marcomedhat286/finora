/// Exception thrown when a transaction cannot be created or applied
/// because it violates a domain rule.
///
/// This exception represents a business-level failure rather than
/// a technical or infrastructure error.
///
/// For example, an expense may be rejected when applying its financial
/// effect would result in an invalid account balance.
class InvalidMakeTransaction implements Exception {
  /// Human-readable explanation of why the transaction was rejected.
  final String message;

  /// Creates an [InvalidMakeTransaction] with the specified error message.
  const InvalidMakeTransaction(this.message);

  /// Returns the exception message when the exception is converted to text.
  ///
  /// This makes the exception easy to display, log, or inspect during
  /// error handling.
  @override
  String toString() => message;
}
