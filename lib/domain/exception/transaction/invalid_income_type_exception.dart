/// Exception thrown when an unsupported income category code is provided.
///
/// This exception represents a domain-level validation error that occurs
/// when the supplied income type does not match any of the categories
/// defined in [IncomeCategory].
///
/// Example:
///
/// ```dart
/// throw InvalidIncomeTypeException(
///   'Invalid income type: unknown',
/// );
/// ```
class InvalidIncomeTypeException implements Exception {
  /// A descriptive message explaining why the income type is invalid.
  final String message;

  /// Creates an [InvalidIncomeTypeException] with the given error [message].
  const InvalidIncomeTypeException(this.message);

  /// Returns the exception message when the exception is converted to a string.
  ///
  /// This makes the exception easy to display in logs, debugging output,
  /// or error-handling layers.
  @override
  String toString() => message;
}
