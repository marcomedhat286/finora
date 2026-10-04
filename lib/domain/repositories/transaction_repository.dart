// domain/repositories/transaction_repository.dart
import 'package:finora/domain/criteria/get_all_transactions_result.dart';
import 'package:finora/domain/criteria/transaction_search_criteria.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/entities/transaction.dart';

abstract class TransactionRepository {
  Future<void> saveTransaction({
    required Transaction transaction,
    required Account account,
  });
  Future<GetAllTransactionsResult> getAllTransactionsUser({
    required List<Account> accounts,
    int? limit,
  });

  Future<List<Transaction>> getOffestLimitTransactionUser({
    required List<Account> accounts,
    required int offest,
    required int limit,
  });

  Future<GetAllTransactionsResult> getAllTransactionsAccount({
    required String accountId,
    int? limit,
  });

  Future<List<Transaction>> getOffestLimitTransactionAccount({
    required String accountId,
    required int offest,
    required int limit,
  });

  Future<List<Transaction>> searchTransactions(
    TransactionSearchCriteria criteria,
  );

  ///////////////////////////////////////////////////////////////////////////////////
  Future<void> updateTransaction(Transaction tx);
  Future<void> deleteTransaction(String txId);
}
