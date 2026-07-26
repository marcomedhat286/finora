import 'package:finora/domain/validators/user_name_validator.dart';

///                   14/7
/// Immutable value object representing a valid username within the domain.
///
/// Unlike a raw [String], a [UserName] guarantees that its value satisfies
/// all business rules defined by the domain before it can exist.
///
/// This class is responsible for preserving one of the domain invariants:
///
/// > "An invalid username must never exist inside the domain model."
///
/// Every instance is validated during creation, making it impossible to
/// accidentally pass invalid username values between entities,
/// services, repositories, or use cases.
///
/// ## Responsibilities
///
/// - Encapsulate a username as a domain-specific type.
/// - Ensure the username always satisfies the domain rules.
/// - Prevent invalid values from entering the domain layer.
/// - Provide immutability after construction.
/// - Support value-based equality instead of reference equality.
///
/// ## Validation
///
/// Validation is delegated to [UserNameValidator].
///
/// If validation fails, object creation is aborted and a domain exception
/// is thrown, preventing the application from working with invalid data.
///
/// ## Equality
///
/// Two [UserName] objects are considered equal when they contain the
/// same username value, regardless of whether they are different
/// instances in memory.
///
/// Example:
///
/// ```dart
/// final first = UserName.create(value: "marco@123");
/// final second = UserName.create(value: "marco@123");
///
/// print(first == second); // true
/// ```
///
/// This class represents a **Value Object** in Domain-Driven Design (DDD)
/// and belongs to the Domain layer of the application's Clean Architecture.
class UserName {
  /// Stores the validated username.
  ///
  /// This value is immutable after construction, ensuring that the
  /// object remains valid throughout its lifetime.
  final String _value;

  /// Creates a validated username instance.
  ///
  /// This constructor is intentionally private to guarantee that every
  /// instance is created through the factory constructor, where the
  /// required validation is performed.
  const UserName._({required String value}) : _value = value;

  /// Creates a new validated [UserName].
  ///
  /// Before an instance is created, the supplied value is validated
  /// using [UserNameValidator].
  ///
  /// Throws:
  ///
  /// - Any exception raised by [UserNameValidator] when the supplied
  ///   username violates the domain rules.
  factory UserName.create({required String value}) {
    /// Validate the supplied value before allowing it to become
    /// part of the domain model.
    UserNameValidator.validateOrThrow(value);

    return UserName._(value: value);
  }

  /// Returns the underlying username.
  ///
  /// This is the canonical string representation of the value object.
  @override
  String toString() => value;

  /// Compares two username value objects by their underlying value.
  ///
  /// Two instances are equal when they contain the same username,
  /// regardless of whether they are the same object in memory.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserName && other._value == _value);
  }

  /// Hash code derived from the underlying username value.
  ///
  /// This guarantees consistency with the overridden equality operator.
  @override
  int get hashCode => _value.hashCode;

  /// Returns the validated username string.
  ///
  /// Accessing the raw value should only be necessary when interacting
  /// with external layers such as APIs, databases, or the presentation layer.
  String get value => _value;
}
