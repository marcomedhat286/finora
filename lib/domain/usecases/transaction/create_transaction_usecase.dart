import 'package:finora/core/utils/parse/money_input_parser.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/entities/expense.dart';
import 'package:finora/domain/entities/income.dart';
import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/domain/enum/transaction/expense_category.dart';
import 'package:finora/domain/enum/transaction/income_category.dart';
import 'package:finora/domain/repositories/account_repository.dart';
import 'package:finora/domain/repositories/transaction_repository.dart';
import 'package:finora/domain/services/transaction/transaction_id_generator.dart';
import 'package:finora/domain/validators/user/validate_date.dart';
import 'package:finora/domain/value_object/account/money.dart';

import 'package:finora/domain/value_object/transaction/transaction_title.dart';

class TransactionCreationResult {
  final Account account;
  final Transaction transaction;

  const TransactionCreationResult({
    required this.account,
    required this.transaction,
  });
}

class CreateTransactionUseCase {
  final TransactionRepository _transactionRepository;
  final AccountRepository _accountRepository;

  CreateTransactionUseCase({
    required this._transactionRepository,
    required this._accountRepository,
  });

  Future<TransactionCreationResult> createExpense({
    required Account account,
    required String rawTitle,
    required String rawAmount,
    required String categoryCode,
    required DateTime createdAt,
    String? description,
  }) async {
    final transactionId = TransactionIdGenerator.generateTransactionId();

    final title = TransactionTitle.create(rawTitle);

    final category = ExpenseCategory.fromCode(categoryCode);

    CreatedAtValidator.validateOrThrow(time: createdAt);

    final doubleValue = MoneyInputParser.parseToDouble(
      value: rawAmount,
      fieldName: 'amount',
    );

    final amountMoney = Money.create(value: doubleValue, inclusiveZero: false);

    final expense = Expense.create(
      id: transactionId,
      accountId: account.id,
      title: title,
      category: category,
      createdAt: createdAt,
      amount: amountMoney,
      description: description,
    );
    print(expense.financialEffect);
    final updatedAccount = account.applyNewTransaction(expense);
    print(updatedAccount);
    await _transactionRepository.saveTransaction(expense);
    await _accountRepository.saveAccount(updatedAccount);
    return TransactionCreationResult(
      account: updatedAccount,
      transaction: expense,
    );
  }

  Future<TransactionCreationResult> createIncome({
    required Account account,
    required String rawTitle,
    required String rawAmount,
    required String categoryCode,
    required DateTime createdAt,
    String? description,
  }) async {
    final transactionId = TransactionIdGenerator.generateTransactionId();

    final title = TransactionTitle.create(rawTitle);

    final category = IncomeCategory.fromCode(categoryCode);

    CreatedAtValidator.validateOrThrow(time: createdAt);

    final doubleValue = MoneyInputParser.parseToDouble(
      value: rawAmount,
      fieldName: 'amount',
    );
    final amountMoney = Money.create(value: doubleValue, inclusiveZero: false);

    final income = Income.create(
      id: transactionId,
      accountId: account.id,
      title: title,
      category: category,
      amount: amountMoney,
      createdAt: createdAt,
      description: description,
    );

    final updatedAccount = account.applyNewTransaction(income);

    await _transactionRepository.saveTransaction(income);
    await _accountRepository.saveAccount(updatedAccount);

    return TransactionCreationResult(
      account: updatedAccount,
      transaction: income,
    );
  }
}
