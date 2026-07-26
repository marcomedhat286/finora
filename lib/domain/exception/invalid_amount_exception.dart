///             15/7
/// Exception thrown when a supplied monetary amount violates
/// the application's financial business rules.
///
/// This exception indicates that a monetary value was provided,
/// but it cannot participate in business operations because it
/// does not satisfy the domain's validation constraints.
///
/// Typical examples include:
///
/// - A negative amount.
/// - `NaN` (Not-a-Number).
/// - Positive or negative infinity.
///
/// The exception belongs to the Domain layer and should be thrown
/// by validators responsible for validating monetary values.
final class InvalidAmountException implements Exception {
  /// Human-readable description of the validation failure.
  ///
  /// This message can be propagated to higher layers
  /// (Application or Presentation) to provide meaningful
  /// feedback to users or developers.
  final String message;

  /// Creates an [InvalidAmountException] with the supplied
  /// error message.
  const InvalidAmountException(this.message);

  /// Returns the exception message.
  @override
  String toString() => message;
}
