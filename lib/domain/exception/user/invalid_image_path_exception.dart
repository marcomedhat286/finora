/// Exception thrown when a profile image does not satisfy
/// the Domain rules for a valid image.
///
/// [InvalidProfileImageException] is used by the Domain validation
/// layer when a profile image contains an invalid or unsupported value.
///
/// For example, it can be thrown when:
///
/// - The image path uses an unsupported file extension.
/// - The provided image does not follow the expected image rules.
///
/// This exception does not perform validation itself.
/// It only represents and carries the error information produced
/// by the validation process.
///
/// Example:
///
/// ```dart
/// throw InvalidProfileImageException(
///   "The image extension is not supported.",
/// );
/// ```
///
/// The typical flow is:
///
/// ```text
/// Raw Image Path
///       ↓
/// ImagePathValidator
///       ↓
/// Invalid?
///       ↓
/// InvalidProfileImageException
/// ```
class InvalidProfileImageException implements Exception {
  /// Contains the human-readable description of the validation error.
  ///
  /// This message can be used by the Presentation layer to display
  /// an appropriate error to the user or by another layer for logging.
  final String message;

  /// Creates an [InvalidProfileImageException] with the specified
  /// error [message].
  const InvalidProfileImageException(this.message);

  /// Returns the exception message as its textual representation.
  ///
  /// This allows the exception to be printed directly:
  ///
  /// ```dart
  /// print(exception);
  /// ```
  ///
  /// resulting in the stored error message.
  @override
  String toString() {
    return message;
  }
}
