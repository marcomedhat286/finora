import 'package:finora/domain/exception/invalid_amount_exception.dart';

/// Provides domain-level validation rules for monetary amounts.
///
/// [MoneyValidator] is responsible for ensuring that monetary values
/// satisfy the financial rules defined by the Domain Layer.
///
/// The validator checks that the provided amount:
///
/// - Is a valid finite number.
/// - Is not `NaN`.
/// - Is not positive or negative infinity.
/// - Is not negative when zero is allowed.
/// - Is strictly greater than zero when zero is not allowed.
///
/// The [inclusiveZero] parameter allows the caller to define whether
/// zero should be considered a valid monetary value.
///
/// When [inclusiveZero] is `true`:
///
/// ```text
/// amount >= 0
/// ```
///
/// When [inclusiveZero] is `false`:
///
/// ```text
/// amount > 0
/// ```
///
/// If the amount violates any of these rules, an
/// [InvalidAmountException] is thrown.
///
/// This validator belongs to the Domain Layer because these rules
/// represent business constraints rather than presentation or
/// infrastructure concerns.
///
/// [MoneyValidator] is intentionally stateless and exposes its
/// validation behavior through a static method.
abstract final class MoneyValidator {
  /// Validates a monetary [amount] and throws when the value is invalid.
  ///
  /// [amount] must be a finite numeric value.
  ///
  /// [inclusiveZero] determines whether zero is accepted:
  ///
  /// - `true` → zero is valid and the amount must be `>= 0`.
  /// - `false` → zero is invalid and the amount must be `> 0`.
  ///
  /// Examples:
  ///
  /// ```dart
  /// MoneyValidator.validateOrThrow(
  ///   amount: 100,
  /// );
  /// ```
  ///
  /// Zero is allowed by default:
  ///
  /// ```dart
  /// MoneyValidator.validateOrThrow(
  ///   amount: 0,
  /// );
  /// ```
  ///
  /// Zero can be rejected explicitly:
  ///
  /// ```dart
  /// MoneyValidator.validateOrThrow(
  ///   amount: 0,
  ///   inclusiveZero: false,
  /// );
  /// // Throws InvalidAmountException
  /// ```
  ///
  /// An [InvalidAmountException] is thrown when:
  ///
  /// - The amount is `NaN`.
  /// - The amount is infinite.
  /// - The amount is negative while zero is allowed.
  /// - The amount is zero or negative while zero is not allowed.
  static void validateOrThrow({
    required double amount,
    bool inclusiveZero = true,
  }) {
    // Reject NaN and infinite values because they do not represent
    // valid finite monetary amounts.
    //
    // Examples of invalid values:
    //
    // ```dart
    // double.nan
    // double.infinity
    // double.negativeInfinity
    // ```
    if (amount.isNaN || amount.isInfinite) {
      throw const InvalidAmountException(
        'Amount must be a valid finite number.',
      );
    }

    // When zero is allowed, the amount must be greater than
    // or equal to zero.
    //
    // Negative monetary amounts are rejected.
    if (inclusiveZero) {
      if (amount < 0) {
        throw const InvalidAmountException('Amount cannot be negative.');
      }
    } else {
      // When zero is not allowed, the amount must be strictly
      // greater than zero.
      //
      // Both zero and negative values are rejected.
      if (amount <= 0) {
        throw const InvalidAmountException(
          'Amount must be strictly greater than zero.',
        );
      }
    }
  }
}
