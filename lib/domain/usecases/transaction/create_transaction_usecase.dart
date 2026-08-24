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
import 'package:finora/domain/value_object/account/money.dart';
import 'package:finora/domain/value_object/transaction/transaction_id.dart';
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
    String? description,
  }) async {
    final doubleValue = MoneyInputParser.parseToDouble(
      value: rawAmount,
      fieldName: 'amount',
    );
    final amountMoney = Money.create(value: doubleValue, inclusiveZero: false);

    final expense = Expense.create(
      id: TransactionId.create(TransactionIdGenerator.generateTransactionId()),
      title: TransactionTitle.create(rawTitle),
      accountId: account.id,
      amount: amountMoney,
      category: ExpenseCategory.fromCode(categoryCode),
      createdAt: DateTime.now(),
      description: description,
    );

    final updatedAccount = account.applyNewTransaction(expense);
    await _transactionRepository.saveTransaction(expense);
    await _accountRepository.saveAccount(updatedAccount);

    return TransactionCreationResult(
      account: updatedAccount,
      transaction: expense,
    );
  }

  Future<Account> createIncome({
    required Account account,
    required String rawTitle,
    required String rawAmount,
    required String categoryCode,
    String? description,
  }) async {
    final doubleValue = MoneyInputParser.parseToDouble(
      value: rawAmount,
      fieldName: 'amount',
    );
    final amountMoney = Money.create(value: doubleValue);

    final income = Income.create(
      id: TransactionId.create(TransactionIdGenerator.generateTransactionId()),
      title: TransactionTitle.create(rawTitle),
      accountId: account.id,
      amount: amountMoney,
      category: IncomeCategory.fromCode(categoryCode),
      createdAt: DateTime.now(),
      description: description,
    );

    // 1. تطبيق الأثر المالي على الـ Account
    final updatedAccount = account.applyNewTransaction(income);

    // 2. حفظ المعاملة وتحديث الحساب المالي
    await _transactionRepository.saveTransaction(income);
    await _accountRepository.saveAccount(updatedAccount);

    return updatedAccount;
  }
}
