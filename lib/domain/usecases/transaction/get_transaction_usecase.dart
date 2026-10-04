import 'package:finora/domain/criteria/get_all_transactions_result.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/domain/repositories/transaction_repository.dart';

class GetTransactionUsecase {
  final TransactionRepository _transactionRepository;

  GetTransactionUsecase({required this._transactionRepository});

  Future<GetAllTransactionsResult> getLimitTransactionsUser({
    required List<Account> accounts,
    required int limit,
  }) async {
    final allTxsResult = await _transactionRepository.getAllTransactionsUser(
      accounts: accounts,
      limit: limit,
    );

    return allTxsResult;
  }

  Future<List<Transaction>> getOffestLimitTransactionsUser({
    required List<Account> accounts,
    required int offest,
    required int limit,
  }) async {
    final allTxsResult = await _transactionRepository
        .getOffestLimitTransactionUser(
          accounts: accounts,
          offest: offest,
          limit: limit,
        );

    return allTxsResult;
  }

  Future<GetAllTransactionsResult> getLimitTransactionAccount({
    required String accountId,
    required int limit,
  }) async {
    final allTxsResult = await _transactionRepository.getAllTransactionsAccount(
      accountId: accountId,
      limit: limit,
    );

    return allTxsResult;
  }

  Future<List<Transaction>> getOffestLimitTransactionsAccount({
    required String accountId,
    required int offest,
    required int limit,
  }) async {
    final allTxsResult = await _transactionRepository
        .getOffestLimitTransactionAccount(
          accountId: accountId,
          offest: offest,
          limit: limit,
        );

    return allTxsResult;
  }

  /////////////////////////////////////////////////////////////////
  Future<GetAllTransactionsResult> getAllTransactionsUser(
    List<Account> accounts,
  ) async {
    final allTxsResult = await _transactionRepository.getAllTransactionsUser(
      accounts: accounts,
    );

    return allTxsResult;
  }

  Future<GetAllTransactionsResult> getAllTransactionAccount(
    String accountId,
  ) async {
    final allTxsResult = await _transactionRepository.getAllTransactionsAccount(
      accountId: accountId,
    );

    return allTxsResult;
  }
}
