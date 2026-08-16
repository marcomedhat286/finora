import 'package:finora/domain/validators/account_id_validator.dart';

/// Represents a validated account identifier as an immutable Value Object.
///
/// [AccountId] encapsulates the unique identifier of an account and
/// guarantees that every instance contains a valid account ID according
/// to the rules defined by [AccountIdValidator].
///
/// The class prevents raw [String] values from being used directly as
/// account identifiers throughout the Domain Layer.
///
/// An [AccountId] can only be created through [AccountId.fromUniqueString],
/// which validates the provided identifier before constructing the
/// Value Object.
///
/// This design ensures that an invalid account ID cannot be represented
/// as a valid [AccountId] inside the Domain.
///
/// [AccountId] follows the principles of:
///
/// - Domain-Driven Design (DDD)
/// - Value Objects
/// - Immutability
/// - Encapsulation
/// - Domain validation
///
/// Example:
///
/// ```dart
/// final accountId = AccountId.fromUniqueString('acc_12345');
///
/// print(accountId.value); // acc_12345
/// ```
///
/// If the provided identifier does not satisfy the domain rules,
/// [AccountIdValidator] throws the appropriate Domain exception and
/// the object is not created.
class AccountId {
  /// The internally stored and validated account identifier.
  ///
  /// The field is private to prevent external code from changing
  /// the identifier after the Value Object has been created.
  ///
  /// Since [AccountId] is immutable, its value remains unchanged
  /// throughout its lifetime.
  final String _value;

  /// Private constructor used to create an [AccountId].
  ///
  /// The constructor is intentionally private to prevent callers
  /// from creating an AccountId without validation.
  ///
  /// All external creation must go through [fromUniqueString],
  /// ensuring that the identifier passes [AccountIdValidator].
  const AccountId._(this._value);

  /// Creates an [AccountId] from a raw String identifier.
  ///
  /// The provided [id] is validated using
  /// [AccountIdValidator.validateOrThrow] before the Value Object
  /// is created.
  ///
  /// The validator is responsible for checking the identifier against
  /// the account ID rules defined by the Domain.
  ///
  /// If the identifier is invalid, a Domain exception is thrown
  /// and no [AccountId] object is created.
  ///
  /// Example:
  ///
  /// ```dart
  /// final accountId = AccountId.fromUniqueString('acc_123');
  /// ```
  factory AccountId.fromUniqueString(String id) {
    // Validate and clean the provided account ID before storing it.
    //
    // At this point, the returned value has successfully passed
    // the domain validation rules.
    final cleanedId = AccountIdValidator.validateOrThrow(id);

    // Create the immutable Value Object only after successful validation.
    return AccountId._(cleanedId);
  }

  /// Returns the validated account identifier.
  ///
  /// The getter exposes the stored value without exposing the private
  /// field itself, preserving encapsulation and immutability.
  String get value => _value;

  /// Determines whether two [AccountId] objects represent the same
  /// account identifier.
  ///
  /// Since [AccountId] is a Value Object, equality is based on the
  /// encapsulated identifier rather than object identity.
  ///
  /// Therefore, two different AccountId instances containing the
  /// same identifier are considered equal.
  ///
  /// Example:
  ///
  /// ```dart
  /// final first = AccountId.fromUniqueString('acc_123');
  /// final second = AccountId.fromUniqueString('acc_123');
  ///
  /// print(first == second); // true
  /// ```
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AccountId && other._value == _value);
  }

  /// Returns a hash code based on the account identifier.
  ///
  /// Because equality is determined by [_value], the hash code is also
  /// derived from [_value].
  ///
  /// This guarantees consistent behavior when [AccountId] is used
  /// inside collections such as [Set] or as a key in a [Map].
  @override
  int get hashCode => _value.hashCode;

  /// Returns the account identifier as a String.
  ///
  /// This is useful for logging, debugging, serialization,
  /// and other situations where a String representation is required.
  @override
  String toString() => _value;
}
