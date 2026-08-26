import 'package:finora/domain/exception/user/invalid_date_time_exception.dart';

/// Validates creation timestamps according to the Domain rules.
///
/// [CreatedAtValidator] is responsible for ensuring that a creation
/// timestamp represents a valid point in time for an entity.
///
/// The validator enforces two main business rules:
///
/// 1. The creation time must not be in the future.
/// 2. The creation year must not be earlier than [minYear].
///
/// By default, the minimum allowed year is 2026.
///
/// This validation belongs to the Domain layer because the validity
/// of an entity's creation timestamp is a business/domain rule and
/// should not depend on the Presentation or Data layers.
///
/// Validation flow:
///
/// ```text
/// DateTime
///    │
///    ▼
/// Get current time + small buffer
///    │
///    ▼
/// Is date in the future?
///    │
///    ├── Yes ──────────────► InvalidDateTimeException
///    │
///    ▼
/// Is year < minimum year?
///    │
///    ├── Yes ──────────────► InvalidDateTimeException
///    │
///    ▼
/// Valid creation timestamp
/// ```
abstract final class CreatedAtValidator {
  /// Validates an entity's creation timestamp.
  ///
  /// [time] is the creation timestamp that needs to be validated.
  ///
  /// [minYear] defines the earliest allowed year.
  /// It defaults to `2026`.
  ///
  /// Throws [InvalidDateTimeException] when:
  ///
  /// - [time] is later than the current time.
  /// - [time]'s year is earlier than [minYear].
  ///
  /// A one-second buffer is added to the current time to avoid
  /// rejecting timestamps that are created immediately before
  /// or during the validation process due to tiny timing differences.
  static void validateOrThrow({required DateTime time, int minYear = 2026}) {
    // Add a very small tolerance window to the current time.
    //
    // This helps prevent false validation failures caused by
    // extremely small differences between the timestamp being
    // validated and DateTime.now() being evaluated.
    final nowWithBuffer = DateTime.now().add(const Duration(seconds: 1));

    // Reject timestamps that:
    //
    // 1. Exist in the future.
    // 2. Belong to a year earlier than the allowed minimum year.
    //
    // Both conditions indicate that the creation timestamp
    // does not satisfy the Domain rules.
    if (time.isAfter(nowWithBuffer) || time.year < minYear) {
      throw const InvalidDateTimeException(
        "Invalid date. The date must not be in the future "
        "and must be from 2026 onward.",
      );
    }
  }
}
