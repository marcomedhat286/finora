import 'package:finora/domain/validators/name_validator.dart';

/// Immutable value object representing a person's name within the domain.
///
/// A [PersonName] guarantees that its underlying value is both
/// **validated** and **normalized** before it can exist.
///
/// Rather than allowing raw strings to flow through the domain,
/// this class encapsulates a person's name as a dedicated type,
/// ensuring that every instance always represents a valid business concept.
///
/// ## Responsibilities
///
/// - Encapsulate a person's name.
/// - Enforce the domain's validation rules.
/// - Store the normalized (trimmed) representation of the name.
/// - Prevent invalid values from entering the domain model.
/// - Provide value-based equality.
///
/// ## Validation & Normalization
///
/// Validation and normalization are delegated to [NameValidator].
///
/// Before an instance is created:
///
/// - Leading and trailing whitespace is removed.
/// - The normalized value is validated against the domain rules.
/// - If validation fails, object creation is aborted and a domain
///   exception is thrown.
///
/// ## Domain Invariant
///
/// > An invalid or non-normalized person's name must never exist
/// > inside the Domain layer.
///
/// This class represents a **Value Object** in Domain-Driven Design (DDD)
/// and belongs to the Domain layer of the application's
/// Clean Architecture.
class PersonName {
  /// Stores the validated and normalized name.
  ///
  /// Once created, this value cannot be modified, preserving
  /// the immutability of the value object.
  final String value;

  /// Creates a validated [PersonName].
  ///
  /// This constructor is intentionally private to guarantee that
  /// every instance is created through [PersonName.create], where
  /// validation and normalization are enforced.
  const PersonName._({required this.value});

  /// Creates a new [PersonName] value object.
  ///
  /// The supplied value is first validated and normalized using
  /// [NameValidator].
  ///
  /// Parameters:
  ///
  /// - [value] The person's name.
  /// - [nameType] Optional descriptive label used when constructing
  ///   validation error messages.
  ///
  /// Returns:
  ///
  /// A validated and normalized [PersonName].
  ///
  /// Throws:
  ///
  /// - Any exception raised by [NameValidator] when the supplied
  ///   value violates the domain rules.
  factory PersonName.create({required String value, String nameType = "name"}) {
    /// Validate and normalize the supplied value before allowing it
    /// to become part of the domain model.
    final cleanName = NameValidator.validateOrThrow(
      name: value,
      nameType: nameType,
    );

    return PersonName._(value: cleanName);
  }

  /// Returns the normalized name.
  ///
  /// This is the canonical string representation of the value object.
  @override
  String toString() => value;

  /// Compares two [PersonName] objects by their underlying value.
  ///
  /// Two instances are considered equal when they contain the same
  /// normalized name, regardless of whether they are different
  /// objects in memory.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PersonName && other.value == value);
  }

  /// Hash code derived from the normalized value.
  ///
  /// This guarantees consistency with the overridden equality operator.
  @override
  int get hashCode => value.hashCode;
}
