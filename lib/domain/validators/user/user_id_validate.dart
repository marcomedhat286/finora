import 'package:finora/domain/exception/user/empty_value_exception.dart';
import 'package:finora/domain/exception/user/invalid_format_exception.dart';

/// Validates User IDs according to the Domain rules.
///
/// [UserIdValidate] is responsible for ensuring that every User ID
/// entering the Domain is:
///
/// - Not null.
/// - Not empty.
/// - Properly formatted as a UUID v4.
///
/// The expected format is:
///
/// ```text
/// xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx
/// ```
///
/// Where:
///
/// - `x` represents a hexadecimal character.
/// - The third UUID section must start with `4`, identifying UUID v4.
/// - The fourth UUID section must start with `8`, `9`, `A`, or `B`,
///   which represents the required UUID variant.
///
/// Example of a valid User ID:
///
/// ```text
/// 550e8400-e29b-41d4-a716-446655440000
/// ```
///
/// This validator does not create a [UserId].
/// Its only responsibility is to validate and return the cleaned value.
///
/// The creation flow is:
///
/// ```text
/// Raw User ID
///      ↓
/// UserIdValidate.validateOrThrow()
///      ↓
/// Null / Empty check
///      ↓
/// UUID v4 format check
///      ↓
/// Validated User ID
/// ```
abstract final class UserIdValidate {
  /// Regular expression used to validate a UUID v4 User ID.
  ///
  /// Breakdown:
  ///
  /// ```text
  /// [0-9a-fA-F]{8}
  ///     ↓
  /// First 8 hexadecimal characters
  ///
  /// -
  ///     ↓
  /// UUID separator
  ///
  /// [0-9a-fA-F]{4}
  ///     ↓
  /// Next 4 hexadecimal characters
  ///
  /// -4[0-9a-fA-F]{3}
  ///     ↓
  /// UUID version 4
  ///
  /// -[89abAB][0-9a-fA-F]{3}
  ///     ↓
  /// UUID variant
  ///
  /// -[0-9a-fA-F]{12}
  ///     ↓
  /// Final 12 hexadecimal characters
  /// ```
  ///
  /// The `^` and `$` anchors ensure that the entire string matches
  /// the expected UUID structure rather than only a part of it.
  static final RegExp _uuidRegex = RegExp(
    r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-4[0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$',
  );

  /// Validates a raw User ID and returns its trimmed value.
  ///
  /// The method accepts a nullable [String] because a User ID may be
  /// missing before it reaches the Domain.
  ///
  /// Validation is performed in the following order:
  ///
  /// 1. Check whether the value is `null`.
  /// 2. Remove unnecessary surrounding whitespace.
  /// 3. Check whether the resulting value is empty.
  /// 4. Validate the UUID v4 format.
  /// 5. Return the cleaned User ID.
  ///
  /// Throws:
  ///
  /// - [EmptyValueException] when the User ID is null or empty.
  /// - [InvalidFormatException] when the User ID does not follow
  ///   the required UUID v4 format.
  static String validateOrThrow(String? userId) {
    // A null User ID means that no identity value was provided.
    if (userId == null) {
      throw const EmptyValueException("The user id must not be empty.");
    }

    // Remove unnecessary whitespace before validating the ID.
    //
    // Example:
    //
    // "  550e8400-e29b-41d4-a716-446655440000  "
    //
    // becomes:
    //
    // "550e8400-e29b-41d4-a716-446655440000"
    final trimmeduserId = userId.trim();

    // Reject an empty string after trimming.
    //
    // This handles values such as:
    //
    // ""
    // "   "
    if (trimmeduserId.isEmpty) {
      throw const EmptyValueException("The user id must not be empty.");
    }

    // Verify that the complete User ID follows the UUID v4 format.
    //
    // If the ID does not match the Domain rule, reject it instead
    // of allowing an invalid identity to enter the Domain.
    if (!_uuidRegex.hasMatch(trimmeduserId)) {
      throw const InvalidFormatException("The user id is not valid");
    }

    // Return the validated and normalized User ID.
    return trimmeduserId;
  }
}
