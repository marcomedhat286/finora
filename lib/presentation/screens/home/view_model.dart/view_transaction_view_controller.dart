import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/domain/usecases/transaction/get_transaction_usecase.dart';
import 'package:finora/presentation/controller/auth_accounts_controller.dart';
import 'package:get/get.dart';

class ViewTransactionController extends GetxController {
  final GetTransactionUsecase _getTransactionUsecase;
  ViewTransactionController(this._getTransactionUsecase);

  final RxList<Transaction> recentTransactions = RxList<Transaction>();

  Future<void> getMoreTransaction() async {
    final accounts = AuthAccountsController.to.userAccounts;
    final result = await _getTransactionUsecase.getAllTransactions(accounts);
    recentTransactions.clear();
    recentTransactions.assignAll(result.alltransactions);
  }

  void removeMoreTransaction() {
    recentTransactions.clear();
  }
}
