/// Exception thrown when an account name does not satisfy
/// the allowed length constraints defined by the Domain.
///
/// [InvalidAccountNameLengthException] represents a specific
/// Domain validation failure where the provided account name
/// is either shorter than the minimum allowed length or longer
/// than the maximum allowed length.
///
/// Unlike a generic validation exception, this exception preserves
/// the actual validation data:
///
/// - [currentLength] → The actual length of the provided account name.
/// - [minLength] → The minimum number of characters allowed.
/// - [maxLength] → The maximum number of characters allowed.
///
/// This information allows upper layers to handle the error
/// intelligently instead of relying only on a preformatted message.
///
/// Example:
///
/// ```dart
/// throw const InvalidAccountNameLengthException(
///   currentLength: 35,
///   minLength: 2,
///   maxLength: 30,
/// );
/// ```
///
/// The resulting message will be:
///
/// ```text
/// Account name length (35) must be between 2 and 30 characters.
/// ```
///
/// The exception is created by [AccountNameValidator] when the
/// account name violates the configured length constraints.
final class InvalidAccountNameLengthException implements Exception {
  /// A human-readable description of the validation failure.
  ///
  /// This message is generated automatically from the actual
  /// and allowed length values.
  final String message;

  /// The actual number of characters in the provided account name.
  final int currentLength;

  /// The minimum number of characters allowed for an account name.
  final int minLength;

  /// The maximum number of characters allowed for an account name.
  final int maxLength;

  /// Creates an [InvalidAccountNameLengthException].
  ///
  /// The [message] is generated automatically using the provided
  /// length information, ensuring that the error message always
  /// reflects the actual validation constraints.
  const InvalidAccountNameLengthException({
    required this.currentLength,
    required this.minLength,
    required this.maxLength,
  }) : message =
           'Account name length ($currentLength) must be between '
           '$minLength and $maxLength characters.';

  /// Returns the generated validation error message.
  ///
  /// This allows the exception to be represented as a readable
  /// String when logged, printed, or handled by an upper layer.
  @override
  String toString() => message;
}
