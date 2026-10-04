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
