import 'package:finora/data/models/transaction_model.dart';

import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/domain/entities/income.dart';
import 'package:finora/domain/entities/expense.dart';
import 'package:finora/domain/enum/transaction/expense_category.dart';
import 'package:finora/domain/enum/transaction/income_category.dart';

import 'package:finora/domain/value_object/account/account_id.dart';
import 'package:finora/domain/value_object/account/money.dart';

import 'package:finora/domain/value_object/transaction/transaction_id.dart';
import 'package:finora/domain/value_object/transaction/transaction_title.dart';

class TransactionMapper {
  /// Converts a domain Transaction into an Isar TransactionModel.
  static TransactionModel toModel(Transaction tx) {
    return TransactionModel()
      ..transactionId = tx.id.value
      ..accountId = tx.accountId.value
      ..title = tx.title.value
      ..description = tx.description
      ..amount = tx.amount.value
      ..category = tx.category.code
      ..type = switch (tx) {
        Income() => 'income',
        Expense() => 'expense',
        _ => throw ArgumentError(
          'Unsupported transaction type: ${tx.runtimeType}',
        ),
      }
      ..createdAt = tx.createdAt;
  }

  /// Converts an Isar TransactionModel into the correct
  /// domain Transaction type.
  static Transaction toEntity(TransactionModel model) {
    switch (model.type) {
      case 'income':
        return Income.create(
          id: TransactionId.create(model.transactionId),
          accountId: AccountId.fromUniqueString(model.accountId),
          title: TransactionTitle.create(model.title),
          description: model.description,
          amount: Money.create(value: model.amount, inclusiveZero: false),
          category: IncomeCategory.fromCode(model.category),
          createdAt: model.createdAt,
        );

      case 'expense':
        return Expense.create(
          id: TransactionId.create(model.transactionId),
          accountId: AccountId.fromUniqueString(model.accountId),
          title: TransactionTitle.create(model.title),
          description: model.description,
          amount: Money.create(value: model.amount, inclusiveZero: false),
          category: ExpenseCategory.fromCode(model.category),
          createdAt: model.createdAt,
        );

      default:
        throw ArgumentError('Unknown transaction type: ${model.type}');
    }
  }
}
