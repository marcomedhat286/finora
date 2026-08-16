import 'package:finora/domain/validators/account_id_validator.dart';
import 'package:finora/domain/validators/title_validator.dart';
import 'package:finora/domain/validators/transaction_id_validator.dart';
import 'package:finora/domain/validators/validate_date.dart';
import 'package:finora/domain/value_object/money.dart';

import 'transaction.dart';

class Expense extends Transaction {
  Expense._({
    required super.id,
    required super.title,
    required super.accountId,
    required super.amount,
    required super.createdAt,
    super.description,
  });

  factory Expense.create({
    required String id,
    required String title,
    required String accountId,
    required double amount,
    required DateTime createdAt,
    String? description,
  }) {
    final cleanedTransactionId = TransactionIdValidator.validateOrThrow(id);
    final cleanedTitle = TitleValidator.validateOrThrow(title: title);
    final cleanedAccountId = AccountIdValidator.validateOrThrow(accountId);
    final amountMoney = Money.create(value: amount, inclusiveZero: true);
    CreatedAtValidator.validateOrThrow(createdAt);

    return Expense._(
      id: cleanedTransactionId,
      title: cleanedTitle,
      accountId: cleanedAccountId,
      amount: amountMoney,
      createdAt: createdAt,
      description: description,
    );
  }
  @override
  double get financialEffect => -amount.value;
  @override
  double get reversalFinancialEffect => amount.value;

  @override
  String get displayData =>
      """$runtimeType{id: $id, title: $title, amount: ${amount.value},
          accountId: $accountId, created At: $createdAt, 
          description: ${description ?? ""}}""";
}
