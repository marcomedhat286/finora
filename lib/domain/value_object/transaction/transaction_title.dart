import 'package:finora/domain/validators/transaction/title_validator.dart';

/// Value Object representing the title of a transaction.
///
/// [TransactionTitle] encapsulates a transaction title and guarantees that
/// the value has passed the domain validation rules before it enters the
/// domain model.
///
/// The actual validation logic is delegated to [TitleValidator], keeping
/// validation rules separate from the value object's responsibility.
///
/// Once created, the title is immutable and cannot be changed.
///
/// Two [TransactionTitle] objects are considered equal when they contain
/// the same validated title value.
class TransactionTitle {
  /// The validated transaction title.
  ///
  /// This value is immutable and cannot be modified after the object is
  /// created.
  final String value;

  /// Private constructor used internally after successful validation.
  ///
  /// Keeping this constructor private prevents external code from creating
  /// a [TransactionTitle] without going through the validation process.
  const TransactionTitle._(this.value);

  /// Creates a validated [TransactionTitle] from a raw string.
  ///
  /// The raw title is passed to [TitleValidator] first.
  ///
  /// [TitleValidator] is responsible for:
  /// - Cleaning the input.
  /// - Checking whether the title is empty.
  /// - Checking whether the title follows the required format.
  ///
  /// If validation fails, the validator throws the appropriate domain
  /// exception and no invalid [TransactionTitle] is created.
  factory TransactionTitle.create(String rawTitle) {
    final cleanedTitle = TitleValidator.validateOrThrow(title: rawTitle);

    return TransactionTitle._(cleanedTitle);
  }

  /// Compares two [TransactionTitle] objects by their actual value.
  ///
  /// This means two different instances containing the same title are
  /// considered equal.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionTitle &&
          runtimeType == other.runtimeType &&
          value == other.value;

  /// Generates a hash code based on the title value.
  ///
  /// This ensures that the equality contract remains valid when the object
  /// is used inside collections such as [Set] or as a [Map] key.
  @override
  int get hashCode => value.hashCode;

  /// Returns the transaction title as a String.
  ///
  /// Useful for logging, debugging, displaying the title, or serialization.
  @override
  String toString() => value;
}
