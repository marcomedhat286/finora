import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/domain/validators/account_id_validator.dart';
import 'package:finora/domain/validators/title_validator.dart';
import 'package:finora/domain/validators/transaction_id_validator.dart';
import 'package:finora/domain/validators/validate_date.dart';
import 'package:finora/domain/value_object/money.dart';

class Income extends Transaction {
  const Income._({
    required super.id,
    required super.title,
    required super.accountId,
    required super.amount,
    required super.createdAt,
    super.description,
  });
  factory Income.create({
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
    final amountMoney = Money.create(value: amount);
    CreatedAtValidator.validateOrThrow(createdAt);

    return Income._(
      id: cleanedTransactionId,
      title: cleanedTitle,
      accountId: cleanedAccountId,
      amount: amountMoney,
      createdAt: createdAt,
      description: description,
    );
  }

  @override
  String get displayData =>
      """$runtimeType{id: $id, title: $title, amount: ${amount.value},
          accountId: $accountId, created At: $createdAt, 
          description: ${description ?? ""}}""";

  @override
  Money get financialEffect => amount;

  @override
  Money get reversalFinancialEffect => -amount;
}
