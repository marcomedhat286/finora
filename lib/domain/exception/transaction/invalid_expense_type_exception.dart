/// Exception thrown when an unsupported expense category code is provided.
///
/// This exception represents a domain-level validation error that occurs
/// when the supplied expense type does not match any of the categories
/// defined in [ExpenseCategory].
///
/// It is typically thrown by [ExpenseTypeValidator] when it cannot find
/// a matching [ExpenseCategory] for the provided code.
///
/// Example:
///
/// ```dart
/// throw InvalidExpenseTypeException(
///   'Invalid expense type: unknown',
/// );
/// ```
class InvalidExpenseTypeException implements Exception {
  /// A descriptive message explaining why the expense type is invalid.
  final String message;

  /// Creates an [InvalidExpenseTypeException] with the given error [message].
  const InvalidExpenseTypeException(this.message);

  /// Returns the exception message when the exception is converted to a string.
  ///
  /// This allows the exception to be easily used in logs, debugging output,
  /// or by higher layers responsible for presenting the error.
  @override
  String toString() => message;
}
