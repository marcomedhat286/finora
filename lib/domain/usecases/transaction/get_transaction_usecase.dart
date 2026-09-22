import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/repositories/transaction_repository.dart';

class GetTransactionUsecase {
  final TransactionRepository _transactionRepository;

  GetTransactionUsecase({required this._transactionRepository});
  Future<GetAllTransactionsResult> getAllTransactions(
    List<Account> accounts,
  ) async {
    final allTxsResult = await _transactionRepository.getAllTransactionsForUser(
      accounts: accounts,
    );

    return allTxsResult;
  }

  Future<GetAllTransactionsResult> getLimitTransactions({
    required List<Account> accounts,
    required int limit,
  }) async {
    final allTxsResult = await _transactionRepository.getAllTransactionsForUser(
      accounts: accounts,
      limit: limit,
    );

    return allTxsResult;
  }
}
