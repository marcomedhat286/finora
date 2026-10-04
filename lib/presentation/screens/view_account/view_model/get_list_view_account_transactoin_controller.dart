import 'package:finora/core/constants.dart';
import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/domain/usecases/transaction/get_transaction_usecase.dart';
import 'package:get/get.dart';

class GetListViewAccountTransactoinController extends GetxController {
  final GetTransactionUsecase _getTransactionUsecase;
  GetListViewAccountTransactoinController(this._getTransactionUsecase);
  // late Worker _transactionsWorker;
  final showTransactions = false.obs;
  final totalIncome = 0.0.obs;
  final totalExpense = 0.0.obs;
  final recentTransactions = <Transaction>[].obs;
  int _offestState = 0;
  final allAccountTransaction = 0.obs;
  final hideState = false.obs;
  final _accountId = ''.obs;

  Future<void> updateShowState(String accountId) async {
    if (!showTransactions.value) {
      await _initiateAccountInformation(accountId);
    } else {
      _closeAccountInformation();
    }
    showTransactions.value = !showTransactions.value;
  }

  Future<void> _initiateAccountInformation(String accountId) async {
    final result = await _getTransactionUsecase.getLimitTransactionAccount(
      accountId: accountId,
      limit: limitTransactionView,
    );
    recentTransactions.addAll(result.alltransactions);
    recentTransactions.refresh();

    totalIncome.value = result.totalIncome;
    totalExpense.value = result.totalExpense;
    allAccountTransaction.value = result.allTransactionsLength;
    _offestState = recentTransactions.length;
    _accountId.value = accountId;
  }

  void _closeAccountInformation() {
    recentTransactions.clear();
    totalIncome.value = 0.0;
    totalExpense.value = 0.0;
    _offestState = 0;
    hideState.value = false;
  }

  Future<void> showMoreTransactionAccountAction() async {
    switch (hideState.value) {
      case false:
        await _getMoreTransactionAccount();
        break;
      case true:
        _closeAccountInformation();
        await _initiateAccountInformation(_accountId.value);
        break;
    }
  }

  Future<void> _getMoreTransactionAccount() async {
    final txs = await _getTransactionUsecase.getOffestLimitTransactionsAccount(
      accountId: _accountId.value,
      offest: _offestState,
      limit: limitTransactionView,
    );

    recentTransactions.addAll(txs);
    recentTransactions.refresh();

    if (_offestState < allAccountTransaction.value) {
      _offestState += txs.length;
    }
    hideState.value = (_offestState == allAccountTransaction.value);
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   if (recentTransactions.isEmpty) {
  //     _initiateAccountInformation();
  //   }
  //   _transactionsWorker = ever(
  //     AuthTransactionsController.to.RxUserTransactions,
  //     (_) async {await _initiateAccountInformation()},
  //   );
  // }

  // @override
  // void onClose() {
  //   _transactionsWorker.dispose();
  //   super.onClose();
  // }
}
