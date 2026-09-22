import 'package:finora/domain/entities/expense.dart';
import 'package:finora/domain/entities/income.dart';
import 'package:finora/domain/enum/transaction/transaction_category_type.dart';
import 'package:finora/domain/value_object/account/account_id.dart';
import 'package:finora/domain/value_object/account/money.dart';
import 'package:finora/domain/value_object/transaction/transaction_id.dart';
import 'package:finora/domain/value_object/transaction/transaction_title.dart';

/// Base domain entity representing a financial transaction.
///
/// [Transaction] defines the common data and behavior shared by all
/// transaction types in the system, such as [Income] and [Expense].
///
/// It also defines the financial effect of a transaction through
/// [financialEffect] and [reversalFinancialEffect], allowing the Account
/// entity to apply or reverse transactions without knowing their concrete
/// type.
///
/// Concrete transaction types are responsible for defining how they affect
/// an account balance.
abstract class Transaction {
  /// Unique identifier of the transaction.
  final TransactionId id;

  /// Human-readable title describing the transaction.
  final TransactionTitle title;

  /// Optional additional information provided for the transaction.
  final String? description;

  /// Date and time at which the transaction was created.
  final DateTime createdAt;

  /// Identifier of the account to which this transaction belongs.
  final AccountId accountId;

  /// Monetary value of the transaction.
  final Money amount;

  /// Business category associated with the transaction.
  ///
  /// The actual category may belong to either an income or expense category.
  final TransactionCategoryType category;

  const Transaction({
    required this.id,
    required this.title,
    required this.accountId,
    required this.amount,
    required this.createdAt,
    required this.category,
    this.description,
  });

  /// Returns the actual financial effect of this transaction on the account.
  ///
  /// For example:
  /// - An [Income] increases the account balance.
  /// - An [Expense] decreases the account balance.
  ///
  /// The concrete transaction type determines the returned value.
  Money get financialEffect;

  /// Returns the financial effect required to reverse this transaction.
  ///
  /// This is mainly used when a transaction is deleted or rolled back.
  ///
  /// For example, if an expense decreases the account balance by 100,
  /// its reversal effect increases the balance by 100.
  Money get reversalFinancialEffect;

  /// Returns a presentation-ready representation of the transaction data.
  ///
  /// Concrete transaction types can override this getter to provide
  /// information suitable for displaying transaction details.
  String get displayData;

  /// Calculates the total amount of all [Expense] transactions.
  ///
  /// The method filters the supplied transaction list and considers only
  /// objects whose concrete type is [Expense].
  ///
  /// Returns the total expense amount as a [double].
  static double getTotalExpenseAmount(List<Transaction> allTransactions) {
    final expenseList = allTransactions.whereType<Expense>();

    return _getTotalTransactionsAmount(expenseList.toList());
  }

  /// Calculates the total amount of all [Income] transactions.
  ///
  /// The method filters the supplied transaction list and considers only
  /// objects whose concrete type is [Income].
  ///
  /// Returns the total income amount as a [double].
  static double getTotalIncomesAmount(List<Transaction> allTransactions) {
    final incomeList = allTransactions.whereType<Income>();

    return _getTotalTransactionsAmount(incomeList.toList());
  }

  /// Calculates the total monetary amount of the supplied transactions.
  ///
  /// The calculation is performed using the [Money] value object rather
  /// than primitive arithmetic so that monetary operations remain
  /// consistent with the domain's money rules.
  static double _getTotalTransactionsAmount(List<Transaction> allTransactions) {
    Money totalEffect = Money.create(value: 0.0);

    for (final tx in allTransactions) {
      totalEffect += tx.amount;
    }

    return totalEffect.value;
  }

  /// Determines whether two transactions represent the same complete state.
  ///
  /// Two transactions are considered equal when all their relevant
  /// properties are equal, including their identifier, title, description,
  /// creation date, account, amount, and category.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Transaction &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          createdAt == other.createdAt &&
          accountId == other.accountId &&
          amount == other.amount &&
          category == other.category;

  /// Generates a hash code based on all properties participating in equality.
  ///
  /// This guarantees that transactions considered equal produce the same
  /// hash code, allowing them to behave correctly inside Sets and Maps.
  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    createdAt,
    accountId,
    amount,
    category,
  );

  static void sortByCreatedTime(List<Transaction> txs) {
    txs.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }
}
