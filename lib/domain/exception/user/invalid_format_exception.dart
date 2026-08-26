/// Thrown when a user-related value does not follow the required
/// Domain format.
///
/// This exception represents a format validation failure.
///
/// Examples:
///
/// ```text
/// Invalid username format
/// Invalid name format
/// Invalid identifier format
/// ```
///
/// The specific validation rule is defined by the corresponding
/// Domain Validator.
final class InvalidFormatException implements Exception {
  /// A human-readable description explaining the expected format.
  final String message;

  /// Creates an [InvalidFormatException] with the specified [message].
  const InvalidFormatException(this.message);

  /// Returns the exception message when the exception is converted
  /// to a String.
  @override
  String toString() => message;
}
