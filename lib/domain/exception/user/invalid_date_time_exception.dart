/// Domain exception thrown when a [DateTime] value does not satisfy
/// the required Domain business rules.
///
/// [InvalidDateTimeException] is a generic Domain-level exception
/// used when a date or timestamp is considered invalid.
///
/// For example, it can be thrown when:
///
/// - A creation date is in the future.
/// - A creation date is earlier than the minimum supported year.
/// - A timestamp violates another Domain-specific date rule.
///
/// This class does not perform any validation by itself.
/// The validation responsibility belongs to a validator such as
/// [CreatedAtValidator].
///
/// The validator detects the invalid condition and throws this
/// exception with a meaningful error message.
///
/// Example:
///
/// ```dart
/// throw const InvalidDateTimeException(
///   "Invalid date. The date must not be in the future.",
/// );
/// ```
///
/// The exception implements [Exception] so higher layers can catch
/// this specific Domain error and handle it appropriately.
final class InvalidDateTimeException implements Exception {
  /// A human-readable message describing why the DateTime
  /// value was rejected.
  ///
  /// This message can be used by higher layers for logging,
  /// debugging, or converting the Domain error into a
  /// user-friendly presentation message.
  final String message;

  /// Creates an [InvalidDateTimeException] with the provided
  /// validation error [message].
  ///
  /// The constructor is `const` because the exception contains
  /// immutable data and has no runtime initialization logic.
  const InvalidDateTimeException(this.message);

  /// Returns the stored error message when the exception is
  /// converted to a String.
  ///
  /// This makes the exception easier to log and inspect.
  @override
  String toString() => message;
}
