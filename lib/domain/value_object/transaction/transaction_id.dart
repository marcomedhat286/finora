import 'package:finora/domain/validators/transaction/transaction_id_validator.dart';

/// Value Object representing the unique identity of a transaction.
///
/// [TransactionId] encapsulates the transaction identifier and ensures that
/// only a valid identifier can enter the domain model.
///
/// The actual validation rules are delegated to [TransactionIdValidator],
/// keeping the validation logic separate from the value object itself.
///
/// Once created, the identifier is immutable and cannot be modified.
///
/// Two [TransactionId] objects are considered equal when they contain the
/// same validated identifier value.
class TransactionId {
  /// The validated transaction identifier.
  ///
  /// This field is private to prevent external code from modifying the
  /// identifier after the object has been created.
  final String value;

  /// Private constructor used only after the identifier has been validated.
  ///
  /// Keeping the constructor private prevents callers from bypassing the
  /// domain validation rules.
  const TransactionId._(this.value);

  /// Creates a valid [TransactionId] from a raw identifier.
  ///
  /// The raw value is first passed to [TransactionIdValidator], which is
  /// responsible for validating and cleaning the identifier.
  ///
  /// If the identifier violates any domain rule, the validator throws the
  /// appropriate domain exception.
  ///
  /// Only a validated identifier can therefore be used to create a
  /// [TransactionId].
  factory TransactionId.create(String rawId) {
    final cleanedId = TransactionIdValidator.validateOrThrow(rawId);

    return TransactionId._(cleanedId);
  }

  /// Compares two [TransactionId] objects by their identifier value.
  ///
  /// [identical] handles the case where both references point to the same
  /// object. Otherwise, equality is based on the actual transaction ID.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionId &&
          runtimeType == other.runtimeType &&
          value == other.value;

  /// Generates a hash code based on the transaction identifier.
  ///
  /// This keeps [TransactionId] compatible with collections such as
  /// [Set] and [Map] when equality is based on [value].
  @override
  int get hashCode => value.hashCode;

  /// Returns the transaction identifier as a String.
  ///
  /// This makes the value object convenient to use in logging, debugging,
  /// serialization, and user-facing diagnostic messages.
  @override
  String toString() => value;
}
