import 'package:finora/data/mapper/account_mapper.dart';
import 'package:finora/data/mapper/transaction_mapper.dart';
import 'package:finora/data/models/account_model.dart';
import 'package:finora/data/models/transaction_model.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/domain/exception/account/not_found_account_exception.dart';

import 'package:finora/domain/repositories/transaction_repository.dart';
import 'package:isar_community/isar.dart';

class IsarTransactionRepository implements TransactionRepository {
  final Isar _isar;

  const IsarTransactionRepository({required this._isar});
  @override
  Future<void> saveTransaction({
    required Transaction transaction,
    required Account account,
  }) async {
    await _isar.writeTxn(() async {
      final transactionModel = TransactionMapper.toModel(transaction);

      await _isar.transactionModels.put(transactionModel);

      final existingAccount = await _isar.accountModels
          .filter()
          .accountIdEqualTo(account.id.value)
          .findFirst();

      if (existingAccount == null) {
        throw NotFoundAccountException('This account is not found');
      }

      final accountModel = AccountMapper.toModel(account);

      accountModel.isarId = existingAccount.isarId;
      await _isar.accountModels.put(accountModel);
    });
  }

  @override
  Future<void> deleteTransaction(String txId) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateTransaction(Transaction tx) {
    throw UnimplementedError();
  }

  @override
  Future<GetAllTransactionsResult> getAllTransactionsForUser({
    required List<Account> accounts,
    int? limit,
  }) async {
    List<Transaction> txs = [];
    if (accounts.isNotEmpty) {
      for (final account in accounts) {
        final txsAccount = await getAllTransactionsForAccount(
          accountId: account.id.value,
        );
        txs.addAll(txsAccount.alltransactions);
      }
    }

    Transaction.sortByCreatedTime(txs);
    if (limit != null && txs.length > limit) {
      return GetAllTransactionsResult(
        allTransactionsLength: txs.length,
        alltransactions: txs.take(limit).toList(),
        totalExpense: Transaction.getTotalExpenseAmount(txs),
        totalIncome: Transaction.getTotalIncomesAmount(txs),
      );
    }

    return GetAllTransactionsResult(
      allTransactionsLength: txs.length,
      alltransactions: txs,
      totalExpense: Transaction.getTotalExpenseAmount(txs),
      totalIncome: Transaction.getTotalIncomesAmount(txs),
    );
  }

  @override
  Future<GetAllTransactionsResult> getAllTransactionsForAccount({
    required String accountId,
    int? limit,
  }) async {
    final allTxs = await _isar.transactionModels
        .filter()
        .accountIdEqualTo(accountId)
        .findAll();

    final transactionEntities = allTxs
        .map((txModel) => TransactionMapper.toEntity(txModel))
        .toList();
    Transaction.sortByCreatedTime(transactionEntities);

    if (limit != null && limit > allTxs.length) {
      return GetAllTransactionsResult(
        allTransactionsLength: allTxs.length,
        alltransactions: transactionEntities.take(limit).toList(),
        totalExpense: Transaction.getTotalExpenseAmount(transactionEntities),
        totalIncome: Transaction.getTotalIncomesAmount(transactionEntities),
      );
    } else {
      return GetAllTransactionsResult(
        allTransactionsLength: allTxs.length,
        alltransactions: transactionEntities,
        totalExpense: Transaction.getTotalExpenseAmount(transactionEntities),
        totalIncome: Transaction.getTotalIncomesAmount(transactionEntities),
      );
    }
  }
}
