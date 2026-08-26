import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/domain/enum/transaction/expense_category.dart';
import 'package:finora/domain/validators/user/validate_date.dart';
import 'package:finora/domain/value_object/account/account_id.dart';
import 'package:finora/domain/value_object/account/money.dart';
import 'package:finora/domain/value_object/transaction/transaction_id.dart';
import 'package:finora/domain/value_object/transaction/transaction_title.dart';

class Expense extends Transaction {
  const Expense._({
    required super.id,
    required super.title,
    required super.accountId,
    required super.amount,
    required super.createdAt,
    required super.category,
    super.description,
  });

  factory Expense.create({
    required TransactionId id,
    required TransactionTitle title,
    required AccountId accountId,
    required Money amount,
    required DateTime createdAt,
    required ExpenseCategory category,
    String? description,
  }) {
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

  @override
  Money get financialEffect => -amount;

  @override
  Money get reversalFinancialEffect => amount;

  @override
  String get displayData =>
      '''Expense{id: $id, title: $title, amount: ${amount.value}, category: ${category.displayName}, accountId: $accountId, createdAt: $createdAt, description: ${description ?? ""}}''';
}
