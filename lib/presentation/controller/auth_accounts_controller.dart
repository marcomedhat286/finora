import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/value_object/account/account_id.dart';
import 'package:get/get.dart';

class AuthAccountsController extends GetxController {
  static AuthAccountsController get to => Get.find<AuthAccountsController>();
  final RxList<Account> _userAccounts = <Account>[].obs;

  void setAccount(List<Account> accounts) {
    _userAccounts.clear();
    Account defaultAccount;
    try {
      if (accounts.isNotEmpty) {
        defaultAccount = accounts.firstWhere((account) => account.isDefault);
        final isRemoved = accounts.remove(defaultAccount);
        _sortAccounts(accounts);
        _userAccounts.insert(0, defaultAccount);
        if (isRemoved) {
          _userAccounts.insertAll(1, accounts);
        }
      }
    } on StateError {
      _sortAccounts(accounts);
      _userAccounts.insertAll(0, accounts);
    }
  }

  void deleteAccount(Account deletedAccount) {
    _userAccounts.removeWhere((account) => account.id == deletedAccount.id);
  }

  void updateDefaultAccount(Account newAccount) {
    _userAccounts[0] = newAccount;
  }

  Account getAccountById(AccountId id) {
    return _userAccounts.firstWhere((account) => account.id == id);
  }

  void _sortAccounts(List<Account> accounts) {
    accounts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Account? get defaultAccount {
    try {
      return _userAccounts.firstWhere((account) => account.isDefault);
    } on StateError {
      return null;
    }
  }

  List<Account> get userAccounts => _userAccounts.toList();

  double get totalCurrentBalanceAccounts =>
      Account.calcAllCurrentBalanceAccounts(userAccounts);

  void logout() {
    _userAccounts.clear();
    super.dispose();
  }
}
