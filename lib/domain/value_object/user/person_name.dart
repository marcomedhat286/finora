import 'package:finora/domain/Extensions/string_operations.dart';
import 'package:finora/domain/validators/user/name_validator.dart';

/// Represents a validated and normalized person's name.
///
/// [PersonName] is a Value Object used to represent names such as:
///
/// ```text
/// First Name
/// Middle Name
/// Last Name
/// ```
///
/// Instead of allowing raw [String] values to enter the Domain,
/// [PersonName] guarantees that the provided name passes through
/// [NameValidator] before an instance is created.
///
/// The creation process also normalizes the name by capitalizing
/// its first character.
///
/// Example:
///
/// ```dart
/// final name = PersonName.create(
///   value: 'marco',
///   nameType: 'first name',
/// );
///
/// print(name); // Marco
/// ```
///
/// The overall flow is:
///
/// ```text
/// Raw String
///     ↓
/// PersonName.create()
///     ↓
/// NameValidator
///     ↓
/// Validated Name
///     ↓
/// capitalizeFirst()
///     ↓
/// PersonName
/// ```
///
/// As a Value Object, equality is based on the name's value rather
/// than the object's memory identity.
class PersonName {
  /// Stores the validated and normalized name.
  ///
  /// The field is final, which makes the [PersonName] immutable after
  /// creation.
  final String value;

  /// Private constructor used only after the name has successfully
  /// passed validation.
  ///
  /// Keeping this constructor private prevents external code from
  /// creating a [PersonName] without using [PersonName.create].
  const PersonName._({required this.value});

  /// Creates a validated and normalized [PersonName].
  ///
  /// [value] is the raw name provided by the caller.
  ///
  /// [nameType] describes the role of the name and is passed to
  /// [NameValidator] so validation errors can provide more meaningful
  /// information.
  ///
  /// Examples:
  ///
  /// ```dart
  /// PersonName.create(
  ///   value: 'marco',
  ///   nameType: 'first name',
  /// );
  ///
  /// PersonName.create(
  ///   value: 'medhat',
  ///   nameType: 'last name',
  /// );
  /// ```
  ///
  /// The name is validated first and then normalized by capitalizing
  /// its first character.
  factory PersonName.create({required String value, String nameType = "name"}) {
    // Validate the raw name before allowing it to enter the Domain.
    //
    // The validator also handles trimming and the Domain-specific
    // name validation rules.
    final cleanName = NameValidator.validateOrThrow(
      name: value,
      nameType: nameType,
    );

    // Normalize the validated name by capitalizing its first character.
    //
    // Example:
    //
    // "marco" → "Marco"
    //
    // The normalized value is then stored inside the Value Object.
    return PersonName._(value: cleanName.capitalizeFirst());
  }

  /// Returns the person's name as a String.
  ///
  /// This makes the Value Object convenient to use when displaying
  /// names or converting them to textual representations.
  @override
  String toString() => value;

  /// Determines whether two [PersonName] objects represent the same
  /// name value.
  ///
  /// Since [PersonName] is a Value Object, equality is based on
  /// the contained value rather than object identity.
  ///
  /// Example:
  ///
  /// ```dart
  /// final first = PersonName.create(value: 'marco');
  /// final second = PersonName.create(value: 'marco');
  ///
  /// first == second; // true
  /// ```
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PersonName && other.value == value);
  }

  /// Generates a hash code based on the name value.
  ///
  /// This keeps the hash code consistent with the custom equality
  /// implementation.
  @override
  int get hashCode => value.hashCode;
}
