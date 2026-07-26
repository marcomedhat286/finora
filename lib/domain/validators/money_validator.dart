import 'package:finora/domain/exception/invalid_amount_exception.dart';

///                   15/7
/// Utility responsible for validating monetary values according to
/// the application's financial business rules.
///
/// A valid monetary amount must:
///
/// - Be a finite numeric value.
/// - Not be `NaN` (Not-a-Number).
/// - Not be positive or negative infinity.
/// - Be greater than or equal to zero.
///
/// Examples of valid amounts:
///
/// ```text
/// 0.0
/// 15.75
/// 100
/// 2500.50
/// ```
///
/// Examples of invalid amounts:
///
/// ```text
/// NaN
/// Infinity
/// -Infinity
/// -25.50
/// ```
///
/// Invalid monetary values are rejected immediately by throwing
/// a domain-specific exception, preventing inconsistent financial
/// data from entering the Domain layer.
abstract final class MoneyValidator {
  /// Validates the supplied monetary amount.
  ///
  /// Validation rules:
  ///
  /// 1. The amount must be a valid numeric value.
  /// 2. The amount must not be infinite.
  /// 3. The amount must not be negative.
  ///
  /// Throws:
  ///
  /// - [InvalidAmountException] if the supplied amount
  ///   violates any of the financial validation rules.
  static void validateOrThrow({
    required double amount,
    bool exclusiveZero = true,
  }) {
    /// Reject invalid numeric values before allowing the amount
    /// to participate in any business operation.

    if (amount.isNaN ||
        amount.isInfinite ||
        (exclusiveZero && amount <= 0) ||
        (exclusiveZero && amount < 0)) {
      throw const InvalidAmountException(
        "Amount must be a finite value greater than or equal to zero.",
      );
    }
  }
}
