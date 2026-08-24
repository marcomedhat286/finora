/// Exception thrown when a required Domain value is empty.
///
/// [EmptyValueException] represents a domain-level validation failure
/// that occurs when a required value is missing or contains no meaningful
/// data.
///
/// This exception can be used by Domain validators when a required
/// value is:
///
/// - An empty String.
/// - A String containing only whitespace after trimming.
/// - Missing when the Domain rule requires the value to be provided.
///
/// Example:
///
/// ```dart
/// throw const EmptyValueException(
///   "UserName can't be empty.",
/// );
/// ```
///
/// The actual validation is performed by the corresponding Domain
/// validator, while this exception is responsible only for representing
/// and communicating the validation failure.
///
/// Keeping this exception inside the Domain Layer allows validators
/// to report missing required values without depending on the
/// Presentation Layer or any framework-specific implementation.
final class EmptyValueException implements Exception {
  /// A descriptive message explaining why the value was considered empty.
  ///
  /// The message should clearly describe which required value is missing
  /// or empty and help the upper layers handle the validation failure.
  final String message;

  /// Creates an [EmptyValueException] with the specified [message].
  ///
  /// The constructor is constant because the exception contains only
  /// immutable data and does not require runtime initialization.
  const EmptyValueException(this.message);

  /// Returns the exception message as the String representation
  /// of this exception.
  ///
  /// This makes the exception convenient for logging, debugging,
  /// and displaying or mapping the error in upper application layers.
  @override
  String toString() => message;
}
