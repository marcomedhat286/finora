///               15/7
/// Exception thrown when a supplied date or time value violates
/// the application's business rules.
///
/// This exception indicates that a [DateTime] value was provided,
/// but it is considered invalid within the domain.
///
/// Typical examples include:
///
/// - A creation date in the future.
/// - An unsupported or malformed date.
/// - A timestamp that violates domain-specific constraints.
///
/// The exception belongs to the Domain layer and should be thrown
/// by validators responsible for validating temporal values.
final class InvalidDateTimeException implements Exception {
  /// Human-readable description of the validation failure.
  ///
  /// This message can be propagated to higher layers
  /// (Application or Presentation) to provide meaningful
  /// feedback to users or developers.
  final String message;

  /// Creates an [InvalidDateTimeException] with the supplied
  /// error message.
  const InvalidDateTimeException(this.message);

  /// Returns the exception message.
  @override
  String toString() => message;
}
