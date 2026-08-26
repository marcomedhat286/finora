import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/domain/entities/user.dart';
import 'package:get/get.dart';

class AuthUserController extends GetxController {
  static AuthUserController get to => Get.find<AuthUserController>();

  final Rxn<User> _currentUser = Rxn<User>();

  final RxList<Account> _userAccounts = <Account>[].obs;
  final RxList<Transaction> _userTransaction = <Transaction>[].obs;

  void setUser(User user) {
    _currentUser.value = user;
  }

  void setAccount(List<Account> accounts) {
    _userAccounts.assignAll(accounts);
  }

  void setTransactions(List<Transaction> transactions) {
    _userTransaction.assignAll(transactions);
  }

  void updateDefaultAccount(Account newAccount) {
    final defaultindex = _userAccounts.indexWhere(
      (account) => (newAccount.id == account.id),
    );
    _userAccounts[defaultindex] = newAccount;
  }

  void addAccount(Account account) {
    _userAccounts.add(account);
  }

  void addTransaction(Transaction transaction) {
    _userTransaction.add(transaction);
  }

  User? get currentUser => _currentUser.value;

  bool get isAuthenticated => (_currentUser.value != null);

  List<Account> get userAccounts => _userAccounts.toList();

  List<Transaction> get userTransactions => _userTransaction.toList();

  double get totalIncomes =>
      Transaction.getTotalIncomesAmount(_userTransaction);
  double get totalExpenses =>
      Transaction.getTotalExpenseAmount(_userTransaction);

  Account? get defaultAccount =>
      _userAccounts.isNotEmpty ? _userAccounts.first : null;

  bool get hasAccounts => (_userAccounts.isNotEmpty);

  void logout() {
    _currentUser.value = null;
    _userAccounts.clear();
    _userTransaction.clear();
    Get.offAllNamed('/welcome');
  }
}
