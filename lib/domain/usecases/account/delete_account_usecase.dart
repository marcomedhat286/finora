import 'package:finora/core/constants.dart';
import 'package:finora/domain/criteria/account_use_case_result.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/repositories/account_repository.dart';
import 'package:finora/domain/repositories/transaction_repository.dart';
import 'package:finora/presentation/controller/auth_accounts_controller.dart';

class DeleteAccountUsecase {
  final AccountRepository _accountRepository;
  final TransactionRepository _transactionRepository;
  DeleteAccountUsecase({
    required this._accountRepository,
    required this._transactionRepository,
  });
  Future<AccountUseCaseResult?> execute(Account account) async {
    final isDeleted = await _accountRepository.deleteAccount(account.id.value);
    AuthAccountsController.to.deleteAccount(account);
    if (account.isDefault &&
        AuthAccountsController.to.userAccounts.isNotEmpty) {
      final newDefualtAccount = AuthAccountsController.to.userAccounts.last;
      await _accountRepository.updateAccount(
        newDefualtAccount.copyWith(newIsDefault: true),
      );
    }
    if (isDeleted) {
      final accounts = await _accountRepository.getAccounts(
        account.userId.value,
      );
      final transactions = await _transactionRepository.getAllTransactionsUser(
        accounts: accounts,
        limit: limitTransactionView,
      );
      return AccountUseCaseResult(
        existingAccounts: accounts,
        existingTransactions: transactions,
      );
    }

    return null;
  }
}
