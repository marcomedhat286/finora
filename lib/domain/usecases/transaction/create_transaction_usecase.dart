import 'package:finora/core/constants.dart';
import 'package:finora/core/utils/parse/money_input_parser.dart';
import 'package:finora/domain/criteria/transaction_creation_result.dart';

import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/entities/expense.dart';
import 'package:finora/domain/entities/income.dart';

import 'package:finora/domain/enum/transaction/expense_category.dart';
import 'package:finora/domain/enum/transaction/income_category.dart';

import 'package:finora/domain/repositories/account_repository.dart';
import 'package:finora/domain/repositories/transaction_repository.dart';

import 'package:finora/domain/services/transaction/transaction_id_generator.dart';

import 'package:finora/domain/validators/user/validate_date.dart';

import 'package:finora/domain/value_object/account/money.dart';
import 'package:finora/domain/value_object/transaction/transaction_title.dart';

/// Application use case responsible for creating financial transactions.
///
/// This class coordinates the complete transaction-creation workflow:
///
/// Raw UI Input
///     ↓
/// Parsing
///     ↓
/// Validation
///     ↓
/// Value Objects / Enums
///     ↓
/// Transaction Entity
///     ↓
/// Apply transaction to Account
///     ↓
/// Persist Transaction + Updated Account
///
/// The use case does not directly depend on Flutter or UI widgets.
/// It coordinates Domain objects and repository abstractions.
class CreateTransactionUseCase {
  /// Repository responsible for persisting transactions.
  final TransactionRepository _transactionRepository;

  /// Repository responsible for persisting the updated account.
  final AccountRepository _accountRepository;

  CreateTransactionUseCase({
    required this._transactionRepository,
    required this._accountRepository,
  });

  /// Creates and persists a new [Expense].
  ///
  /// The workflow performs:
  ///
  /// 1. Generate a unique transaction ID.
  /// 2. Validate and create the transaction title.
  /// 3. Convert the category code into [ExpenseCategory].
  /// 4. Validate the transaction date.
  /// 5. Parse the raw amount from String to double.
  /// 6. Convert the amount into the [Money] value object.
  /// 7. Create the [Expense] entity.
  /// 8. Apply the expense to the account balance.
  /// 9. Persist the transaction.
  /// 10. Persist the updated account.
  /// 11. Return both the created transaction and updated account.
  Future<TransactionCreationResult> createExpense({
    required Account account,
    required String rawTitle,
    required String rawAmount,
    required String categoryCode,
    required DateTime createdAt,
    String? description,
  }) async {
    // Generate a unique ID before constructing the transaction entity.
    final transactionId = TransactionIdGenerator.generateTransactionId();

    // Convert the raw title into a validated TransactionTitle value object.
    final title = TransactionTitle.create(rawTitle);

    // Convert the raw category code into a strongly typed ExpenseCategory.
    final category = ExpenseCategory.fromCode(categoryCode);

    // Ensure that the transaction date satisfies the domain date rules.
    CreatedAtValidator.validateOrThrow(time: createdAt);

    // Convert the raw String amount received from the UI into a double.
    final doubleValue = MoneyInputParser.parseToDouble(
      value: rawAmount,
      fieldName: 'amount',
    );

    // Create a Money value object.
    //
    // Expenses must be strictly greater than zero because an expense
    // with an amount of zero has no financial meaning.
    final amountMoney = Money.create(value: doubleValue, inclusiveZero: false);

    // Construct the concrete Expense domain entity.
    final expense = Expense.create(
      id: transactionId,
      accountId: account.id,
      title: title,
      category: category,
      createdAt: createdAt,
      amount: amountMoney,
      description: description,
    );

    // Apply the expense's financial effect to the account.
    //
    // Expense.financialEffect returns -amount, so this operation
    // decreases the account balance.
    //
    // If applying the expense violates a domain rule, such as
    // insufficient funds, the Account entity will reject the operation.
    final updatedAccount = account.applyNewTransaction(expense);

    // Persist the transaction only after the domain operation succeeds.
    await _transactionRepository.saveTransaction(
      transaction: expense,
      account: updatedAccount,
    );

    final accounts = await _accountRepository.getAccounts(
      updatedAccount.userId.value,
    );

    final transactionsResult = await _transactionRepository
        .getAllTransactionsUser(
          accounts: accounts,
          limit: limitTransactionView,
        );

    // Return both results so the caller can immediately update its state.
    return TransactionCreationResult(
      accounts: accounts,
      transactionsResult: transactionsResult,
    );
  }

  /// Creates and persists a new [Income].
  ///
  /// The workflow is almost identical to [createExpense], but the
  /// resulting transaction is an [Income], whose financial effect is
  /// positive and therefore increases the account balance.
  Future<TransactionCreationResult> createIncome({
    required Account account,
    required String rawTitle,
    required String rawAmount,
    required String categoryCode,
    required DateTime createdAt,
    String? description,
  }) async {
    // Generate a unique transaction ID.
    final transactionId = TransactionIdGenerator.generateTransactionId();

    // Validate and wrap the raw title inside the TransactionTitle
    // value object.
    final title = TransactionTitle.create(rawTitle);

    // Convert the category code into a strongly typed IncomeCategory.
    final category = IncomeCategory.fromCode(categoryCode);

    // Validate the transaction creation date.
    CreatedAtValidator.validateOrThrow(time: createdAt);

    // Parse the raw amount received from the UI.
    final doubleValue = MoneyInputParser.parseToDouble(
      value: rawAmount,
      fieldName: 'amount',
    );

    // Create the Money value object.
    //
    // Zero is not allowed for a real financial transaction.
    final amountMoney = Money.create(value: doubleValue, inclusiveZero: false);

    // Construct the concrete Income domain entity.
    final income = Income.create(
      id: transactionId,
      accountId: account.id,
      title: title,
      category: category,
      amount: amountMoney,
      createdAt: createdAt,
      description: description,
    );

    // Apply the income's financial effect to the account.
    //
    // Income.financialEffect returns +amount, so the account balance
    // increases.
    final updatedAccount = account.applyNewTransaction(income);

    // Persist the newly created income transaction.
    await _transactionRepository.saveTransaction(
      transaction: income,
      account: updatedAccount,
    );

    final accounts = await _accountRepository.getAccounts(
      updatedAccount.userId.value,
    );

    final transactionsResult = await _transactionRepository
        .getAllTransactionsUser(
          accounts: accounts,
          limit: limitTransactionView,
        );

    // Return both the created income and the updated account.
    return TransactionCreationResult(
      accounts: accounts,
      transactionsResult: transactionsResult,
    );
  }
}
