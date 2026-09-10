import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/domain/entities/user.dart';
import 'package:finora/domain/value_object/account/account_id.dart';
import 'package:get/get.dart';

class AuthUserController extends GetxController {
  static AuthUserController get to => Get.find<AuthUserController>();
  /////////////////////////// user //////////////////////////////////////
  final Rxn<User> _currentUser = Rxn<User>();

  void setUser(User user) {
    _currentUser.value = user;
  }

  User? get currentUser => _currentUser.value;

  ///////////////////////////////////////////////////////////////////////

  /////////////////////////// Accounts //////////////////////////////////
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
    if (currentUser != null) {
      if (currentUser!.id == account.userId) {
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

  final RxList<Transaction> _userTransaction = <Transaction>[].obs;
  ///////////////////////////////////////////////////////////////////////

  void setTransactions(List<Transaction> transactions) {
    _userTransaction.assignAll(transactions);
  }

  void addTransaction(Transaction transaction) {
    _userTransaction.add(transaction);
  }

  List<Transaction> get userTransactions => _userTransaction.toList();

  double get totalIncomes =>
      Transaction.getTotalIncomesAmount(_userTransaction);
  double get totalExpenses =>
      Transaction.getTotalExpenseAmount(_userTransaction);

  void logout() {
    _currentUser.value = null;
    _userAccounts.clear();
    _userTransaction.clear();
    Get.offAllNamed('/welcome');
  }
}
