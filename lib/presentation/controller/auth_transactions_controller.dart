import 'package:finora/domain/criteria/get_all_transactions_result.dart';
import 'package:finora/domain/entities/transaction.dart';
import 'package:get/get.dart';

class AuthTransactionsController extends GetxController {
  static AuthTransactionsController get to =>
      Get.find<AuthTransactionsController>();

  final RxList<Transaction> _userTransaction = <Transaction>[].obs;
  final transactionLength = 0.obs;
  final _totalIncome = 0.0.obs;
  final _totalExpense = 0.0.obs;

  void setTransactions(GetAllTransactionsResult result) {
    _userTransaction.clear();
    _userTransaction.assignAll(result.alltransactions);
    transactionLength.value = result.allTransactionsLength;
    _totalExpense.value = result.totalExpense;
    _totalIncome.value = result.totalIncome;
    _userTransaction.refresh();
  }

  double get totalIncomes => _totalIncome.value;
  double get totalExpenses => _totalExpense.value;

  List<Transaction> get userTransactions => _userTransaction.toList();
  RxList<Transaction> get RxUserTransactions => _userTransaction;

  void logout() {
    _userTransaction.clear();
    transactionLength.value = 0;
    _totalExpense.value = 0;
    _totalIncome.value = 0;
  }
}
