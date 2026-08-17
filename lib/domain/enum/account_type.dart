import 'package:finora/domain/validators/account_type_validator.dart';

/// Represents the supported account types within the Domain.
///
/// [AccountType] defines the different categories of financial accounts
/// that can exist in the application.
///
/// Each account type contains two representations:
///
/// - [code] → A stable machine-readable identifier used for storage,
///   serialization, APIs, or database operations.
/// - [displayName] → A human-readable name intended for presentation
///   purposes.
///
/// Keeping these two representations separate prevents the value shown
/// to the user from becoming tightly coupled to the value stored by
/// the application.
///
/// Example:
///
/// ```dart
/// AccountType.bank.code;
/// // bank
///
/// AccountType.bank.displayName;
/// // Bank
/// ```
///
/// The supported account types are:
///
/// - [AccountType.bank] → Bank account.
/// - [AccountType.cash] → Cash account.
/// - [AccountType.creditCard] → Credit card account.
/// - [AccountType.savings] → Savings account.
/// - [AccountType.investment] → Investment account.
///
/// An [AccountType] can also be created from its stored [code] using
/// [AccountType.fromCode].
///
/// Example:
///
/// ```dart
/// final type = AccountType.fromCode('bank');
///
/// print(type); // Bank
/// ```
///
/// Validation and parsing of external codes are delegated to
/// [AccountTypeValidator], keeping the enum focused on representing
/// valid account types.
enum AccountType {
  /// Represents a traditional bank account.
  bank('bank', 'Bank'),

  /// Represents physical or available cash.
  cash('cash', 'Cash'),

  /// Represents a credit card account.
  creditCard('credit_card', 'Credit Card'),

  /// Represents a savings account.
  savings('savings', 'Saving Account'),

  /// Represents an investment account.
  investment('investment', 'Investment');

  /// Stable machine-readable identifier for this account type.
  ///
  /// This value is suitable for persistence, serialization,
  /// database storage, and communication with external systems.
  final String code;

  /// Human-readable representation of this account type.
  ///
  /// This value is intended for display purposes and should not
  /// be relied upon as the persisted identifier.
  final String displayName;

  /// Creates an [AccountType] with its [code] and [displayName].
  ///
  /// The constructor is constant because enum values are immutable.
  const AccountType(this.code, this.displayName);

  /// Creates an [AccountType] from its machine-readable [code].
  ///
  /// The provided code is passed to [AccountTypeValidator], which
  /// validates the value and returns the corresponding enum member.
  ///
  /// If the code is not supported, the validator throws the
  /// appropriate Domain exception.
  ///
  /// Example:
  ///
  /// ```dart
  /// final accountType = AccountType.fromCode('credit_card');
  ///
  /// print(accountType); // Credit Card
  /// ```
  factory AccountType.fromCode(String code) {
    // Delegate validation and conversion to the dedicated
    // Domain validator.
    return AccountTypeValidator.validateAndParse(code);
  }

  /// Returns the human-readable name of the account type.
  ///
  /// This allows an AccountType to be directly used in contexts
  /// where a readable String representation is required.
  ///
  /// Example:
  ///
  /// ```dart
  /// print(AccountType.savings);
  /// // Saving Account
  /// ```
  @override
  String toString() => displayName;
}
