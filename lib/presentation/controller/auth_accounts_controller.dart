import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/value_object/account/account_id.dart';
import 'package:finora/presentation/controller/auth_user_controller.dart';
import 'package:get/get.dart';

class AuthAccountsController extends GetxController {
  static AuthAccountsController get to => Get.find<AuthAccountsController>();
  final RxList<Account> _userAccounts = <Account>[].obs;
  void setAccount(List<Account> accounts) {
    final defaultAccount = accounts.firstWhere(
      (account) => account.isDefault,
      orElse: () => accounts.first,
    );
    final isRemoved = accounts.remove(defaultAccount);

    _userAccounts.insert(0, defaultAccount);
    if (isRemoved) {
      accounts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      _userAccounts.insertAll(1, accounts);
    }
  }

  void addAccount(Account account) {
    final currentUser = AuthUserController.to.currentUser;
    if (currentUser != null) {
      if (currentUser.id == account.userId) {
        _userAccounts.insert(1, account);
      }
    }
  }

  void updateDefaultAccount(Account newAccount) {
    _userAccounts[0] = newAccount;
  }

  void setNewDefaultAccount(Account newDefaultAccount) {
    final oldDefaultAccount = defaultAccount;
    if (oldDefaultAccount == null) return;
    final indexDefault = _userAccounts.indexOf(oldDefaultAccount);
    _userAccounts[indexDefault] = oldDefaultAccount.copyWith(
      newIsDefault: false,
    );
    _userAccounts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    _userAccounts.insert(0, newDefaultAccount);
    _userAccounts.refresh();
  }

  Account? get defaultAccount => _userAccounts.isNotEmpty
      ? _userAccounts.firstWhere((account) => account.isDefault)
      : null;

  Account getByAccountId(AccountId id) {
    return _userAccounts.firstWhere((account) => account.id == id);
  }

  List<Account> get userAccounts => _userAccounts.toList();
  double get totalCurrentBalanceAccounts =>
      Account.calcAllCurrentBalanceAccounts(userAccounts);
}
