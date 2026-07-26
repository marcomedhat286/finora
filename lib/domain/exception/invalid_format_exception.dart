///             15/7
/// Exception thrown when a supplied value does not satisfy
/// the required business format.
///
/// This exception indicates that the provided input exists,
/// but its structure or representation violates one or more
/// domain validation rules.
///
/// Typical examples include:
///
/// - Invalid username format.
/// - Invalid account identifier format.
/// - Invalid personal name format.
///
/// The exception belongs to the Domain layer and should be
/// thrown by validators when an input fails format validation.
final class InvalidFormatException implements Exception {
  /// Human-readable description of the validation failure.
  ///
  /// This message can be propagated to higher layers
  /// (Application or Presentation) to provide meaningful
  /// feedback to users or developers.
  final String message;

  /// Creates an [InvalidFormatException] with the supplied
  /// error message.
  const InvalidFormatException(this.message);

  /// Returns the exception message.
  @override
  String toString() => message;
}
