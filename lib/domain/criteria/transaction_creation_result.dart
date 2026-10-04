import 'package:finora/domain/criteria/get_all_transactions_result.dart';
import 'package:finora/domain/entities/account.dart';

/// Represents the result of a successful transaction creation.
///
/// Creating a transaction affects two domain objects:
///
/// 1. The newly created [Transaction].
/// 2. The [Account] after applying the transaction's financial effect.
///
/// Returning both objects allows the application layer or presentation
/// layer to update its state without having to recalculate the account
/// balance or retrieve the transaction again.
class TransactionCreationResult {
  /// The account after the transaction has been applied.
  final List<Account> accounts;

  /// The newly created transaction.
  final GetAllTransactionsResult transactionsResult;

  const TransactionCreationResult({
    required this.accounts,
    required this.transactionsResult,
  });
}
