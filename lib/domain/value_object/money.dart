import 'package:finora/domain/validators/money_validator.dart';

/// Represents a monetary value as an immutable Domain Value Object.
///
/// [Money] encapsulates a numeric monetary amount and ensures that
/// the value always satisfies the financial rules defined by the
/// Domain.
///
/// Instead of using raw [double] values throughout the application,
/// this Value Object provides a controlled representation of money
/// and prevents invalid monetary values from entering the Domain.
///
/// The value is rounded to exactly two decimal places during creation
/// and is validated through [MoneyValidator].
///
/// The class also provides arithmetic operations such as addition
/// and subtraction while ensuring that the result is converted back
/// into a validated [Money] object.
///
/// This class follows the principles of:
///
/// - Domain-Driven Design (DDD)
/// - Value Objects
/// - Immutability
/// - Encapsulation
///
/// Because [Money] is immutable, an existing instance cannot be
/// modified after creation. Arithmetic operations return new [Money]
/// instances instead.
///
/// Example:
///
/// ```dart
/// final balance = Money.create(value: 100.50);
/// final expense = Money.create(value: 25.25);
///
/// final remaining = balance - expense;
///
/// print(remaining); // 75.25
/// ```
class Money {
  /// The internally stored monetary value.
  ///
  /// This field is private to prevent external code from modifying
  /// the amount without going through the Domain validation rules.
  ///
  /// The value is guaranteed to have been validated and rounded
  /// before being assigned.
  final double _value;

  /// Private constructor used to create a [Money] instance.
  ///
  /// This constructor is intentionally private so that callers cannot
  /// create a Money object without passing through [Money.create].
  ///
  /// This guarantees that every Money instance is created from a
  /// validated monetary value.
  const Money._({required this._value});

  /// Creates a validated [Money] Value Object.
  ///
  /// [value] represents the monetary amount.
  ///
  /// [inclusiveZero] determines whether zero is considered a valid
  /// monetary value.
  ///
  /// By default, zero is allowed:
  ///
  /// ```dart
  /// Money.create(value: 0);
  /// ```
  ///
  /// When [inclusiveZero] is false, the Domain validator can reject
  /// zero according to the application's business rules.
  ///
  /// Before validation, the amount is rounded to two decimal places.
  /// This ensures that the Money object consistently represents
  /// monetary values with standard financial precision.
  ///
  /// If the rounded value violates the rules defined by
  /// [MoneyValidator], a Domain exception is thrown.
  ///
  /// Example:
  ///
  /// ```dart
  /// final money = Money.create(value: 125.456);
  ///
  /// print(money.value); // 125.46
  /// ```
  factory Money.create({required double value, bool inclusiveZero = true}) {
    // Round the monetary value to two decimal places before
    // performing validation and storing it.
    //
    // This keeps the internal representation consistent with
    // the expected precision of monetary values.
    final roundedValue = double.parse(value.toStringAsFixed(2));

    // Validate the rounded amount against the Domain's
    // financial rules.
    //
    // The validator is responsible for rejecting values such as
    // negative amounts, NaN, infinity, or zero when zero is not allowed.
    MoneyValidator.validateOrThrow(
      amount: roundedValue,
      inclusiveZero: inclusiveZero,
    );

    // Create the immutable Money Value Object only after
    // successful validation.
    return Money._(value: roundedValue);
  }

  /// Adds another [Money] value to this value.
  ///
  /// The result is returned as a new validated [Money] object.
  ///
  /// The original objects remain unchanged because [Money] is immutable.
  ///
  /// Example:
  ///
  /// ```dart
  /// final first = Money.create(value: 100);
  /// final second = Money.create(value: 50);
  ///
  /// final result = first + second;
  ///
  /// print(result); // 150.00
  /// ```
  Money operator +(Money other) =>
      Money.create(value: _value + other.value, inclusiveZero: true);

  /// Subtracts another [Money] value from this value.
  ///
  /// The result is returned as a new validated [Money] object.
  ///
  /// The operation itself does not modify either of the original
  /// Money instances.
  ///
  /// If the subtraction produces an invalid monetary value,
  /// [MoneyValidator] is responsible for rejecting the result.
  ///
  /// Example:
  ///
  /// ```dart
  /// final balance = Money.create(value: 100);
  /// final expense = Money.create(value: 25);
  ///
  /// final remaining = balance - expense;
  ///
  /// print(remaining); // 75.00
  /// ```
  Money operator -(Money other) =>
      Money.create(value: _value - other.value, inclusiveZero: true);

  /// Returns a new [Money] instance with the sign of the current value inverted.
  ///
  /// This unary minus operator allows a [Money] value to be negated while
  /// preserving the validation and rounding rules enforced by [Money.create].
  ///
  /// For example:
  ///
  /// ```dart
  /// final money = Money.create(value: 100);
  /// final negativeMoney = -money;
  ///
  /// print(negativeMoney); // -100.00
  /// ```
  ///
  /// [inclusiveZero] is set to `true` because zero remains a valid monetary
  /// value when the sign is inverted.
  Money operator -() => Money.create(value: -_value, inclusiveZero: true);

  /// Indicates whether the monetary value is exactly zero.
  ///
  /// Returns `true` when the stored value equals `0`.
  ///
  /// Example:
  ///
  /// ```dart
  /// final money = Money.create(value: 0);
  ///
  /// print(money.isZero); // true
  /// ```
  bool get isZero => _value == 0;

  /// Returns the monetary value formatted with exactly two decimal places.
  ///
  /// This representation is useful when displaying the amount
  /// as a human-readable monetary value.
  ///
  /// Example:
  ///
  /// ```dart
  /// final money = Money.create(value: 100);
  ///
  /// print(money.toString()); // 100.00
  /// ```
  @override
  String toString() => _value.toStringAsFixed(2);

  /// Determines whether two [Money] objects represent the same amount.
  ///
  /// Because [Money] is a Value Object, equality is based on the
  /// encapsulated monetary value rather than object identity.
  ///
  /// Therefore, two different Money instances containing the same
  /// amount are considered equal.
  ///
  /// Example:
  ///
  /// ```dart
  /// final first = Money.create(value: 100);
  /// final second = Money.create(value: 100);
  ///
  /// print(first == second); // true
  /// ```
  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other is Money && other.value == _value);
  }

  /// Returns the raw numeric monetary value.
  ///
  /// The returned value is already rounded and validated according
  /// to the Domain rules.
  double get value => _value;

  /// Returns a hash code based on the monetary value.
  ///
  /// Since equality is based on [value], the hash code must also
  /// be derived from the same value to maintain the equality/hash
  /// code contract.
  @override
  int get hashCode => _value.hashCode;
}
