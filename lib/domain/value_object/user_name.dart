import 'package:finora/domain/validators/user_name_validator.dart';

/// Represents a validated username as an immutable Value Object.
///
/// The [UserName] class is responsible for representing a username
/// inside the Domain Layer in a valid and controlled form.
///
/// Instead of allowing raw [String] values to be used throughout the
/// application, this Value Object guarantees that every [UserName]
/// instance has already passed the required domain validation rules.
///
/// The validation is performed when the object is created through
/// [UserName.create]. If the provided username is invalid, the
/// [UserNameValidator] throws the appropriate domain exception and
/// the object will not be created.
///
/// This approach follows the principles of:
/// - Domain-Driven Design (DDD)
/// - Value Objects
/// - Clean Architecture
/// - Encapsulation
///
/// The class is immutable, meaning that once a [UserName] object is
/// created, its value cannot be changed.
///
/// Example:
/// ```dart
/// final userName = UserName.create(value: 'marco@123');
///
/// print(userName.value); // marco@123
/// ```
///
/// Invalid values are rejected during creation:
/// ```dart
/// UserName.create(value: 'invalid username');
/// // Throws a domain validation exception.
/// ```
class UserName {
  /// The internally stored username value.
  ///
  /// This field is private to prevent external code from modifying
  /// or bypassing the validation rules of the Value Object.
  ///
  /// The value can only be assigned through the private constructor
  /// after it has successfully passed [UserNameValidator].
  final String _value;

  /// Private constructor used to create a [UserName] instance.
  ///
  /// The constructor is intentionally private so that objects cannot
  /// be created directly without going through [UserName.create].
  ///
  /// This guarantees that every [UserName] object is created only after
  /// the required domain validation has been successfully completed.
  const UserName._({required this._value});

  /// Creates a validated [UserName] Value Object.
  ///
  /// The provided [value] is passed to [UserNameValidator.validateOrThrow]
  /// which is responsible for validating the username according to the
  /// application's domain rules.
  ///
  /// The validator also returns the processed username value, which is
  /// stored inside the Value Object.
  ///
  /// If the username is invalid, a domain exception is thrown and
  /// no [UserName] object is created.
  ///
  /// This factory method acts as the single controlled entry point
  /// for creating valid [UserName] objects.
  factory UserName.create({required String value}) {
    // Validate the username before creating the Value Object.
    //
    // The validator is responsible for enforcing the domain rules
    // and returning the validated/trimmed value.
    final trimmedUserName = UserNameValidator.validateOrThrow(value);

    // Create the Value Object only after successful validation.
    return UserName._(value: trimmedUserName);
  }

  /// Returns the username as a String.
  ///
  /// This allows the Value Object to be easily used in places where
  /// a String representation of the username is required, such as
  /// logging, UI display, serialization, or debugging.
  @override
  String toString() => value;

  /// Determines whether two [UserName] objects represent the same value.
  ///
  /// Value Objects are compared by their value rather than by their
  /// object identity.
  ///
  /// Therefore, two different [UserName] instances containing the
  /// same username are considered equal.
  ///
  /// Example:
  /// ```dart
  /// final first = UserName.create(value: 'marco@123');
  /// final second = UserName.create(value: 'marco@123');
  ///
  /// print(first == second); // true
  /// ```
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserName && other._value == _value);
  }

  /// Returns a hash code based on the username value.
  ///
  /// Since equality is determined by [_value], the hash code must also
  /// be generated from [_value].
  ///
  /// This ensures that [UserName] behaves correctly when used inside
  /// collections such as [Set] or as a key inside a [Map].
  @override
  int get hashCode => _value.hashCode;

  /// Returns the validated username value.
  ///
  /// The getter exposes the value without exposing the private field
  /// itself, while keeping the Value Object immutable.
  String get value => _value;
}
