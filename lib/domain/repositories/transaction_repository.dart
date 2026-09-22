// domain/repositories/transaction_repository.dart
import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/entities/transaction.dart';

final class GetAllTransactionsResult {
  final int allTransactionsLength;
  final List<Transaction> alltransactions;
  final double totalExpense;
  final double totalIncome;
  const GetAllTransactionsResult({
    required this.allTransactionsLength,
    required this.alltransactions,
    required this.totalExpense,
    required this.totalIncome,
  });
}

abstract class TransactionRepository {
  Future<void> saveTransaction({
    required Transaction transaction,
    required Account account,
  });
  Future<void> updateTransaction(Transaction tx);
  Future<void> deleteTransaction(String txId);

  Future<GetAllTransactionsResult> getAllTransactionsForUser({
    required List<Account> accounts,
    int? limit,
  });

  Future<GetAllTransactionsResult> getAllTransactionsForAccount({
    required String accountId,
    int? limit,
  });
}
