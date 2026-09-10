import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/domain/entities/user.dart';
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
  final RxList<Transaction> _userTransaction = <Transaction>[].obs;

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
    _userTransaction.clear();
    Get.offAllNamed('/welcome');
  }
}
