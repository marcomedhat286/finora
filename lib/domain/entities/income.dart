import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/domain/enum/transaction/income_category.dart';
import 'package:finora/domain/validators/user/validate_date.dart';
import 'package:finora/domain/value_object/account/account_id.dart';
import 'package:finora/domain/value_object/account/money.dart';
import 'package:finora/domain/value_object/transaction/transaction_id.dart';
import 'package:finora/domain/value_object/transaction/transaction_title.dart';

/// Represents an income transaction within the domain.
///
/// [Income] is a concrete implementation of the abstract [Transaction]
/// entity. It inherits all common transaction data and defines the behavior
/// specific to money entering an account.
///
/// The most important domain rule implemented here is that an income
/// increases the account balance, while its reversal decreases the balance.
class Income extends Transaction {
  /// Private constructor used to create a valid immutable [Income].
  ///
  /// Creation should normally happen through [Income.create], which performs
  /// the required domain validation before constructing the entity.
  const Income._({
    required super.id,
    required super.title,
    required super.accountId,
    required super.amount,
    required super.createdAt,
    required super.category,
    super.description,
  });

  /// Creates a new [Income] after validating its creation date.
  ///
  /// The [category] is strongly typed as [IncomeCategory], which guarantees
  /// that an income cannot accidentally be created using an expense category.
  factory Income.create({
    required TransactionId id,
    required TransactionTitle title,
    required AccountId accountId,
    required Money amount,
    required DateTime createdAt,
    required IncomeCategory category,
    String? description,
  }) {
    // Ensure that the transaction creation date satisfies
    // the domain rules before the entity is created.
    CreatedAtValidator.validateOrThrow(time: createdAt);

    return Income._(
      id: id,
      title: title,
      accountId: accountId,
      amount: amount,
      createdAt: createdAt,
      category: category,
      description: description,
    );
  }

  /// Creates a new [Income] based on the current instance.
  ///
  /// Since [Income] is immutable, this method does not modify the existing
  /// object. Instead, it creates and returns a new instance containing
  /// the requested changes.
  ///
  /// Properties that are not provided keep their current values.
  Income copyWith({
    TransactionTitle? title,
    Money? amount,
    IncomeCategory? category,
    String? description,
  }) {
    return Income._(
      id: id,
      title: title ?? this.title,
      accountId: accountId,
      amount: amount ?? this.amount,
      createdAt: createdAt,
      category: category ?? this.category,
      description: description ?? this.description,
    );
  }

  /// Defines how an income affects the account balance.
  ///
  /// An income represents money entering the account, therefore its financial
  /// effect is positive and equal to the transaction amount.
  ///
  /// Example:
  ///     Balance = 1000
  ///     Income  = 500
  ///     New Balance = 1500
  @override
  Money get financialEffect => amount;

  /// Defines how an income is reversed.
  ///
  /// Reversing an income removes the money that was previously added to
  /// the account, therefore the reversal effect is the negative value
  /// of the original amount.
  ///
  /// Example:
  ///     Income = +500
  ///     Reversal = -500
  @override
  Money get reversalFinancialEffect => -amount;

  /// Returns a readable representation of the income transaction.
  ///
  /// This is useful for debugging, logging, or inspecting the entity's
  /// complete state.
  @override
  String get displayData =>
      '''Income{id: $id, title: $title, amount: ${amount.value}, category: ${category.displayName}, accountId: $accountId, createdAt: $createdAt, description: ${description ?? ""}}''';
}
