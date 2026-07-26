import 'package:finora/domain/validators/money_validator.dart';

///                       15/7
/// Immutable value object representing a monetary amount within the domain.
///
/// A [Money] guarantees that its underlying value satisfies all financial
/// business rules before it can exist.
///
/// Rather than passing raw `double` values throughout the application,
/// the domain uses this type to ensure that every monetary amount is
/// valid, immutable, and represents a meaningful business concept.
///
/// ## Responsibilities
///
/// - Encapsulate a monetary amount.
/// - Enforce the domain's financial validation rules.
/// - Prevent invalid monetary values from entering the domain.
/// - Provide value-based equality.
/// - Represent money as a strongly typed domain concept instead of
///   using primitive data types.
///
/// ## Validation
///
/// Validation is delegated to [MoneyValidator].
///
/// Before an instance is created, the supplied amount is verified to:
///
/// - Be a valid numeric value.
/// - Not be `NaN`.
/// - Not be infinite.
/// - Be greater than or equal to zero.
///
/// If validation fails, object creation is aborted and a domain
/// exception is thrown.
///
/// ## Domain Invariant
///
/// > An invalid monetary amount must never exist inside the Domain layer.
///
/// This class represents a **Value Object** in Domain-Driven Design (DDD)
/// and belongs to the Domain layer of the application's
/// Clean Architecture.
class Money {
  /// Stores the validated monetary amount.
  ///
  /// Once created, this value cannot be modified,
  /// preserving the immutability of the value object.
  final double value;

  /// Creates a validated [Money].
  ///
  /// This constructor is intentionally private to guarantee that every
  /// instance is created through [Money.create], where validation
  /// is enforced.
  const Money._({required this.value});

  /// Creates a new validated [Money] value object.
  ///
  /// Before construction, the supplied amount is validated using
  /// [MoneyValidator].
  ///
  /// Parameters:
  ///
  /// - [value] The monetary amount.
  ///
  /// Returns:
  ///
  /// A validated [Money] value object.
  ///
  /// Throws:
  ///
  /// - Any exception raised by [MoneyValidator] when the supplied
  ///   amount violates the domain's financial rules.
  factory Money.create({required double value, bool exclusiveZero = true}) {
    /// Ensure the supplied amount satisfies all financial
    /// constraints before becoming part of the domain model.

    MoneyValidator.validateOrThrow(amount: value, exclusiveZero: exclusiveZero);

    return Money._(value: value);
  }

  /// Returns the monetary amount as its canonical string representation.
  @override
  String toString() => "$value";

  /// Compares two [Money] objects by their underlying amount.
  ///
  /// Two instances are considered equal when they represent
  /// the same monetary value, regardless of whether they are
  /// different objects in memory.
  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other is Money && other.value == value);
  }

  /// Hash code derived from the underlying monetary value.
  ///
  /// This guarantees consistency with the overridden equality operator.
  @override
  int get hashCode => value.hashCode;
}
