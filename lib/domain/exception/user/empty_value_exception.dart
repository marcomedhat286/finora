/// Thrown when a required user-related value is empty.
///
/// This exception represents a Domain validation failure where a
/// required value was not provided.
///
/// Examples:
///
/// ```text
/// Empty username
/// Empty first name
/// Empty required user field
/// ```
///
/// It is typically thrown by Domain Validators when they receive
/// an empty or whitespace-only value.
final class EmptyValueException implements Exception {
  /// A human-readable description of the validation failure.
  final String message;

  /// Creates an [EmptyValueException] with the specified [message].
  const EmptyValueException(this.message);

  /// Returns the exception message when the exception is converted
  /// to a String.
  ///
  /// This makes the exception easy to display, log, or inspect
  /// during error handling.
  @override
  String toString() => message;
}
