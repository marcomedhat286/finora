import 'package:finora/domain/validators/user/user_name_validator.dart';

/// Represents a validated username within the Domain layer.
///
/// [UserName] is a Value Object that encapsulates the username value
/// and guarantees that every instance is created through the
/// [UserNameValidator].
///
/// Instead of allowing the application to pass raw `String` values
/// everywhere, [UserName] provides a strongly typed representation
/// of a valid username.
///
/// The creation flow is:
///
/// ```text
/// Raw String
///     ↓
/// UserName.create()
///     ↓
/// UserNameValidator
///     ↓
/// Validated String
///     ↓
/// UserName
/// ```
///
/// Once a [UserName] object is successfully created, its value cannot
/// be changed because the internal value is immutable.
///
/// As a Value Object, two [UserName] instances are considered equal
/// when they contain the same username value, regardless of whether
/// they are the same object instance.
class UserName {
  /// Stores the validated username internally.
  ///
  /// The field is private to prevent external code from modifying
  /// the username without going through the Domain validation rules.
  final String _value;

  /// Private constructor used only after the username has been
  /// successfully validated.
  ///
  /// Keeping this constructor private ensures that callers cannot
  /// bypass [UserNameValidator].
  const UserName._({required this._value});

  /// Creates a validated [UserName] from a raw String.
  ///
  /// The provided value is passed to [UserNameValidator], which is
  /// responsible for checking and cleaning the username according
  /// to the Domain rules.
  ///
  /// If the username is invalid, the validator throws the appropriate
  /// Domain exception and no [UserName] object is created.
  factory UserName.create({required String value}) {
    // Validate the raw username before allowing it into the Domain.
    //
    // The validator also returns the cleaned/trimmed value so the
    // Value Object stores a normalized representation.
    final trimmedUserName = UserNameValidator.validateOrThrow(value);

    // Create the Value Object only after successful validation.
    return UserName._(value: trimmedUserName);
  }

  /// Returns the username as a String.
  ///
  /// This allows the Value Object to be used naturally in places
  /// where its textual representation is required.
  @override
  String toString() => value;

  /// Determines whether two [UserName] objects represent the same
  /// username value.
  ///
  /// Value Objects use value-based equality rather than identity-based
  /// equality.
  ///
  /// Therefore:
  ///
  /// ```dart
  /// UserName.create(value: 'marco@123') ==
  /// UserName.create(value: 'marco@123')
  /// ```
  ///
  /// evaluates to `true`.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserName && other._value == _value);
  }

  /// Generates a hash code based on the username value.
  ///
  /// This is required to keep [hashCode] consistent with the custom
  /// equality implementation above.
  ///
  /// Objects with equal username values must produce the same
  /// hash code.
  @override
  int get hashCode => _value.hashCode;

  /// Exposes the validated username value.
  ///
  /// The returned String cannot modify the internal state because
  /// Strings and the Value Object itself are immutable.
  String get value => _value;
}
