import 'package:finora/domain/Extensions/string_operations.dart';
import 'package:finora/domain/validators/account_name_validator.dart';

/// Represents an account name as an immutable Domain Value Object.
///
/// [AccountName] encapsulates the name assigned to a financial account
/// and ensures that the name satisfies the business rules defined by
/// [AccountNameValidator].
///
/// The account name is validated before the Value Object is created,
/// and its first character is normalized using [capitalizeFirst].
///
/// This prevents invalid or inconsistently formatted account names
/// from being represented inside the Domain.
///
/// [AccountName] follows the Value Object principles:
///
/// - **Immutability:** The stored value cannot be changed after creation.
/// - **Validation:** Every value must pass [AccountNameValidator].
/// - **Encapsulation:** The raw String is controlled by the Value Object.
/// - **Value-based equality:** Two AccountName objects with the same
///   value are considered equal.
///
/// Example:
///
/// ```dart
/// final accountName = AccountName.create('savings account');
///
/// print(accountName); // Savings account
/// ```
///
/// If the provided name violates the Domain validation rules,
/// [AccountNameValidator] throws the appropriate Domain exception.
final class AccountName {
  /// The validated and normalized account name.
  ///
  /// This value is immutable and can only be assigned when the
  /// [AccountName] object is created.
  ///
  /// The value is guaranteed to have passed [AccountNameValidator]
  /// and to have been normalized using [capitalizeFirst].
  final String value;

  /// Private constructor used to create an [AccountName].
  ///
  /// The constructor is intentionally private to prevent callers
  /// from creating an AccountName without going through the
  /// validation and normalization process.
  const AccountName._(this.value);

  /// Creates an [AccountName] from a raw String value.
  ///
  /// The provided [rawValue] goes through two steps:
  ///
  /// 1. **Validation:** The value is checked against the business
  ///    rules defined by [AccountNameValidator].
  ///
  /// 2. **Normalization:** The first character of the validated
  ///    name is capitalized to keep account names consistently formatted.
  ///
  /// If validation fails, a Domain exception is thrown and the
  /// AccountName object is not created.
  ///
  /// Example:
  ///
  /// ```dart
  /// final name = AccountName.create('my savings');
  ///
  /// print(name.value); // My savings
  /// ```
  factory AccountName.create(String rawValue) {
    // Validate the raw account name according to the Domain rules.
    //
    // The returned value has already passed the required validation.
    final validatedName = AccountNameValidator.validateOrThrow(rawValue);

    // Normalize the validated name by capitalizing its first character.
    //
    // This keeps the stored representation consistent throughout
    // the application.
    return AccountName._(validatedName.capitalizeFirst());
  }

  /// Determines whether two [AccountName] objects represent
  /// the same account name.
  ///
  /// Since [AccountName] is a Value Object, equality depends on
  /// the encapsulated value rather than the identity of the object.
  ///
  /// Example:
  ///
  /// ```dart
  /// final first = AccountName.create('savings');
  /// final second = AccountName.create('savings');
  ///
  /// print(first == second); // true
  /// ```
  ///
  /// The [runtimeType] check ensures that equality is only established
  /// between objects of the same concrete type.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountName &&
          runtimeType == other.runtimeType &&
          value == other.value;

  /// Returns a hash code based on the account name value.
  ///
  /// Because equality is based on [value], the hash code must also
  /// be derived from the same value to maintain the equality/hashCode
  /// contract.
  ///
  /// This allows [AccountName] to be safely used in collections such
  /// as [Set] and as keys in a [Map].
  @override
  int get hashCode => value.hashCode;

  /// Returns the account name as a String.
  ///
  /// This is useful for logging, debugging, serialization,
  /// and displaying the account name.
  @override
  String toString() => value;
}
