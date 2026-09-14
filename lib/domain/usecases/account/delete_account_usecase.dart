import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/repositories/account_repository.dart';
import 'package:finora/presentation/controller/auth_accounts_controller.dart';

class DeleteAccountUsecase {
  final AccountRepository _accountRepository;
  DeleteAccountUsecase({required this._accountRepository});
  Future<List<Account>?> execute(Account account) async {
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
      return _accountRepository.getAccounts(account.userId.value);
    }
    return null;
  }
}
