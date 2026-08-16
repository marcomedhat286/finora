/// Exception thrown when a domain value does not match the
/// required format defined by the application's business rules.
///
/// [InvalidFormatException] is a Domain Layer exception used to
/// indicate that a provided value has a valid presence but does not
/// follow the expected structural or formatting rules.
///
/// For example, this exception may be thrown when:
///
/// - A username does not follow the required username pattern.
/// - An account ID does not match the required ID format.
/// - A value object receives a string with an invalid structure.
///
/// Example:
///
/// ```dart
/// throw const InvalidFormatException(
///   'Invalid username format.',
/// );
/// ```
///
/// The exception stores a descriptive [message] explaining the reason
/// for the validation failure.
///
/// Keeping this exception inside the Domain Layer allows domain
/// validators to communicate validation failures without depending
/// on the Presentation Layer or any Flutter-specific implementation.
final class InvalidFormatException implements Exception {
  /// A descriptive message explaining why the provided value
  /// was rejected by the domain validation rules.
  final String message;

  /// Creates an [InvalidFormatException] with the given [message].
  ///
  /// The message should clearly describe the validation rule that
  /// was violated so that the upper layers can handle or display
  /// the error appropriately.
  const InvalidFormatException(this.message);

  /// Returns the exception message as its String representation.
  ///
  /// This makes the exception easier to log, debug, or inspect when
  /// it is converted to a String.
  @override
  String toString() => message;
}
