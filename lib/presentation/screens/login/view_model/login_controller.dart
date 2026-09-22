import 'package:finora/core/constants.dart';
import 'package:finora/domain/usecases/account/get_accounts_usecase.dart';
import 'package:finora/domain/usecases/transaction/get_transaction_usecase.dart';
import 'package:finora/domain/usecases/user/get_user_usecase.dart';
import 'package:finora/presentation/controller/auth_accounts_controller.dart';
import 'package:finora/presentation/controller/auth_transactions_controller.dart';
import 'package:finora/presentation/controller/auth_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final GetUserByUsernameUseCase _getUserByUsernameUseCase;
  final GetAccountsUsecase _getAccountsUsecase;
  final GetTransactionUsecase _getTransactionUsecase;
  LoginController({
    required this._getUserByUsernameUseCase,
    required this._getAccountsUsecase,
    required this._getTransactionUsecase,
  });

  final TextEditingController userNameController = TextEditingController();
  final userNameError = RxnString();
  final isLoading = false.obs;

  Future<void> sumbitLogin() async {
    try {
      isLoading.value = true;
      _resetErrors();
      final user = await _getUserByUsernameUseCase.execute(
        userNameController.text,
      );
      AuthUserController.to.setUser(user);

      final accountsResult = await _getAccountsUsecase.execute(user.id.value);

      final transactionsResult = await _getTransactionUsecase
          .getLimitTransactions(
            accounts: accountsResult,
            limit: limitTransactionView,
          );

      AuthAccountsController.to.setAccount(accountsResult);
      AuthTransactionsController.to.setTransactions(transactionsResult);

      Get.offAllNamed('/home');
    } on Exception catch (e) {
      userNameError.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void _resetErrors() {
    userNameError.value = null;
  }

  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }
}
