///                 15/7
/// Exception thrown when a required value is missing or empty.
///
/// This exception indicates that a mandatory input was either:
///
/// - `null` (when applicable),
/// - an empty string,
/// - or contains only whitespace characters.
///
/// Unlike [InvalidFormatException], this exception is thrown
/// because no meaningful value was supplied, rather than because
/// the value has an incorrect format.
///
/// The exception belongs to the Domain layer and should be thrown
/// by validators responsible for ensuring that required values
/// are present before applying further validation rules.
final class EmptyValueException implements Exception {
  /// Human-readable description of the validation failure.
  ///
  /// This message can be propagated to higher layers
  /// (Application or Presentation) to provide meaningful
  /// feedback to users or developers.
  final String message;

  /// Creates an [EmptyValueException] with the supplied
  /// error message.
  const EmptyValueException(this.message);

  /// Returns the exception message.
  @override
  String toString() => message;
}
