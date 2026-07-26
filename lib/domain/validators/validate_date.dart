import 'package:finora/domain/exception/invalid_date_time_exception.dart';

///             15/7
/// Utility responsible for validating date and time values according
/// to the application's temporal business rules.
///
/// A valid date must:
///
/// - Not be in the future.
/// - Not be earlier than the minimum supported year (**2026**).
///
/// Examples of valid dates:
///
/// ```text
/// 2026-01-01
/// 2027-05-12
/// Current date and time
/// ```
///
/// Examples of invalid dates:
///
/// ```text
/// A future date
/// 2025-12-31
/// 2000-01-01
/// ```
///
/// Invalid dates are rejected immediately by throwing
/// [InvalidDateTimeException], preventing inconsistent temporal
/// values from entering the Domain layer.
abstract final class CreatedAtValidator {
  /// Validates the supplied date and time.
  ///
  /// Validation rules:
  ///
  /// 1. The supplied date must not be in the future.
  /// 2. The supplied year must not be earlier than **2026**.
  ///
  /// Throws:
  ///
  /// - [InvalidDateTimeException] if the supplied date
  ///   violates any temporal business rule.
  static void validateOrThrow(DateTime time) {
    /// Reject dates that violate the domain's temporal constraints.
    if (time.isAfter(DateTime.now()) || time.year < 2026) {
      throw const InvalidDateTimeException(
        "Invalid date. The date must not be in the future and must be from 2026 onward.",
      );
    }
  }
}
