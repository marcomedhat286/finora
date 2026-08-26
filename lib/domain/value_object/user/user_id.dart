import 'package:finora/domain/validators/user/user_id_validate.dart';

/// Represents a validated and immutable User ID within the Domain layer.
///
/// [UserId] is a Value Object used to represent the identity of a user
/// without exposing a raw [String] throughout the Domain.
///
/// Instead of passing user IDs as plain strings:
///
/// ```dart
/// String userId
/// ```
///
/// the Domain can use:
///
/// ```dart
/// UserId userId
/// ```
///
/// This provides stronger type safety and guarantees that a [UserId]
/// can only be created after passing the Domain validation rules.
///
/// The creation flow is:
///
/// ```text
/// Raw String
///     ↓
/// UserId.create()
///     ↓
/// UserIdValidate.validateOrThrow()
///     ↓
/// Validated ID
///     ↓
/// UserId
/// ```
///
/// Once created, the ID cannot be changed because the internal value
/// is immutable.
///
/// As a Value Object, two [UserId] instances are considered equal
/// when they contain the same ID value.
class UserId {
  /// Stores the validated user ID.
  ///
  /// The field is final so the identity of a [UserId] cannot be changed
  /// after the object has been created.
  final String value;

  /// Private constructor used internally after successful validation.
  ///
  /// Keeping this constructor private prevents external code from
  /// creating a [UserId] without going through [UserId.create].
  const UserId._(this.value);

  /// Creates a validated [UserId] from a raw String.
  ///
  /// The provided value is passed to [UserIdValidate], which applies
  /// the Domain rules for valid user IDs.
  ///
  /// If the value is invalid, the validator throws the appropriate
  /// Domain exception and no [UserId] object is created.
  factory UserId.create(String value) {
    // Validate and normalize the raw ID before allowing it
    // to enter the Domain.
    final cleanedId = UserIdValidate.validateOrThrow(value);

    // Create the Value Object only after successful validation.
    return UserId._(cleanedId);
  }

  /// Determines whether two [UserId] objects represent the same
  /// user identity.
  ///
  /// Value Objects use value-based equality rather than object identity.
  ///
  /// Therefore, two different [UserId] instances containing the same
  /// ID value are considered equal.
  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other is UserId && other.value == value);
  }

  /// Generates a hash code based on the user ID value.
  ///
  /// This keeps [hashCode] consistent with the custom equality
  /// implementation above.
  @override
  int get hashCode => value.hashCode;

  /// Returns the raw validated ID as a String.
  ///
  /// Useful when the ID needs to be logged, serialized, or passed
  /// to infrastructure/repository code.
  @override
  String toString() => value;
}
