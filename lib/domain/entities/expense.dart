import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/domain/enum/transaction/expense_category.dart';
import 'package:finora/domain/validators/user/validate_date.dart';
import 'package:finora/domain/value_object/account/account_id.dart';
import 'package:finora/domain/value_object/account/money.dart';
import 'package:finora/domain/value_object/transaction/transaction_id.dart';
import 'package:finora/domain/value_object/transaction/transaction_title.dart';

/// Represents an expense transaction within the domain.
///
/// [Expense] is a concrete implementation of the abstract [Transaction]
/// entity.
///
/// Unlike an [Income], an expense represents money leaving an account.
/// Therefore, its [financialEffect] is negative while its
/// [reversalFinancialEffect] is positive.
///
/// This allows the [Account] entity to update its balance without knowing
/// whether the transaction is an income or an expense.
class Expense extends Transaction {
  /// Private constructor used to create an immutable [Expense].
  ///
  /// Instances should normally be created through [Expense.create], which
  /// performs the required domain validation before construction.
  const Expense._({
    required super.id,
    required super.title,
    required super.accountId,
    required super.amount,
    required super.createdAt,
    required super.category,
    super.description,
  });

  /// Creates a new [Expense] after validating its creation date.
  ///
  /// The [category] is strongly typed as [ExpenseCategory], ensuring that
  /// an expense cannot accidentally be assigned an income category.
  factory Expense.create({
    required TransactionId id,
    required TransactionTitle title,
    required AccountId accountId,
    required Money amount,
    required DateTime createdAt,
    required ExpenseCategory category,
    String? description,
  }) {
    // Validate the transaction creation date before constructing
    // the domain entity.
    CreatedAtValidator.validateOrThrow(time: createdAt);

    return Expense._(
      id: id,
      title: title,
      accountId: accountId,
      amount: amount,
      createdAt: createdAt,
      category: category,
      description: description,
    );
  }

  /// Creates a new [Expense] based on the current instance.
  ///
  /// [Expense] is immutable, so this method does not modify the current
  /// object. Instead, it returns a new instance containing the requested
  /// changes while preserving the remaining values.
  Expense copyWith({
    TransactionTitle? title,
    Money? amount,
    ExpenseCategory? category,
    String? description,
  }) {
    return Expense._(
      id: id,
      title: title ?? this.title,
      accountId: accountId,
      amount: amount ?? this.amount,
      createdAt: createdAt,
      category: category ?? this.category,
      description: description ?? this.description,
    );
  }

  /// Defines how an expense affects the account balance.
  ///
  /// An expense represents money leaving the account, therefore its financial
  /// effect is the negative value of the transaction amount.
  ///
  /// Example:
  ///     Balance = 1000
  ///     Expense = 200
  ///     New Balance = 800
  @override
  Money get financialEffect => -amount;

  /// Defines how an expense is reversed.
  ///
  /// When an expense is deleted or rolled back, the amount that was
  /// previously removed from the account must be added back.
  ///
  /// Example:
  ///     Expense = -200
  ///     Reversal = +200
  @override
  Money get reversalFinancialEffect => amount;

  /// Returns a readable representation of the expense transaction.
  ///
  /// Useful for debugging, logging, and inspecting the entity's state.
  @override
  String get displayData =>
      '''Expense{id: $id, title: $title, amount: ${amount.value}, category: ${category.displayName}, accountId: $accountId, createdAt: $createdAt, description: ${description ?? ""}}''';
}
