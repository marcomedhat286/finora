/// Domain exception thrown when a user's birth date
/// does not satisfy the application's business rules.
///
/// [InvalidBirthdateException] is used by the Domain layer
/// to communicate that the provided birth date is invalid.
///
/// This exception does not perform any validation itself.
/// The validation is handled by [BirthdateValidator], while
/// this class is responsible only for carrying and exposing
/// the validation error message.
///
/// Examples of invalid birth dates include:
///
/// - A birth date that is in the future.
/// - A calculated age below the minimum allowed age.
/// - A calculated age above the maximum allowed age.
///
/// Example:
///
/// ```dart
/// throw InvalidBirthdateException(
///   message: "The birth date is invalid.",
/// );
/// ```
///
/// The exception implements [Exception] so it can be caught
/// separately from other types of Domain exceptions.
class InvalidBirthdateException implements Exception {
  /// A human-readable description explaining why
  /// the birth date was rejected.
  ///
  /// The message is provided by the component that performs
  /// the validation, such as [BirthdateValidator].
  final String message;

  /// Creates an [InvalidBirthdateException] with the given
  /// validation error [message].
  ///
  /// The constructor is `const` because the exception itself
  /// contains immutable data.
  const InvalidBirthdateException({required this.message});

  /// Returns the exception's message when the exception is
  /// converted to a String.
  ///
  /// This allows the exception to be easily logged, displayed,
  /// or handled by higher layers such as the Presentation layer.
  @override
  String toString() => message;
}
