import 'package:finora/core/constants.dart';
import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/domain/usecases/transaction/get_transaction_usecase.dart';
import 'package:finora/presentation/controller/auth_accounts_controller.dart';
import 'package:finora/presentation/controller/auth_transactions_controller.dart';
import 'package:get/get.dart';

class ViewTransactionController extends GetxController {
  final GetTransactionUsecase _getTransactionUsecase;
  ViewTransactionController(this._getTransactionUsecase);
  late Worker _transactionsWorker;
  final RxList<Transaction> recentTransactions = RxList<Transaction>();
  int _offestState = 0;
  final hideState = false.obs;
  final transactionController = AuthTransactionsController.to;
  void initiateRecent() {
    recentTransactions.clear();
    final leastTransactions = transactionController.userTransactions;
    recentTransactions.addAll(leastTransactions);
    recentTransactions.refresh();
    _offestState = leastTransactions.length;
    hideState.value = false;
  }

  Future<void> setRecentTransactionsStateAction() async {
    switch (hideState.value) {
      case true:
        _removeMoreTransaction();
        break;
      case false:
        await _getMoreTransaction();
        break;
    }
  }

  Future<void> _getMoreTransaction() async {
    final accounts = AuthAccountsController.to.userAccounts;

    final txs = await _getTransactionUsecase.getOffestLimitTransactionsUser(
      accounts: accounts,
      offest: _offestState,
      limit: limitTransactionView,
    );

    recentTransactions.addAll(txs);
    recentTransactions.refresh();
    if (_offestState < transactionController.transactionLength.value) {
      _offestState += txs.length;
    }
    hideState.value =
        (_offestState == transactionController.transactionLength.value);
  }

  void _removeMoreTransaction() {
    initiateRecent();
    hideState.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    if (recentTransactions.isEmpty) {
      initiateRecent();
    }
    _transactionsWorker = ever(
      AuthTransactionsController.to.RxUserTransactions,
      (_) => initiateRecent(),
    );
  }

  @override
  void onClose() {
    _transactionsWorker.dispose();
    super.onClose();
  }
}
