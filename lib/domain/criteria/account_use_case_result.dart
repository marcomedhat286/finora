import 'package:finora/domain/criteria/get_all_transactions_result.dart';
import 'package:finora/domain/entities/account.dart';

class AccountUseCaseResult {
  final List<Account> existingAccounts;
  final GetAllTransactionsResult existingTransactions;
  const AccountUseCaseResult({
    required this.existingAccounts,
    required this.existingTransactions,
  });
}
