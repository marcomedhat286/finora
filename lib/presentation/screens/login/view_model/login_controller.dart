import 'package:finora/domain/usecases/account/get_accounts_usecase.dart';
import 'package:finora/domain/usecases/user/get_user_usecase.dart';
import 'package:finora/presentation/controller/auth_accounts_controller.dart';
import 'package:finora/presentation/controller/auth_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final GetUserByUsernameUseCase _getUserByUsernameUseCase;
  final GetAccountsUsecase _accountsUsecase;
  LoginController({
    required this._getUserByUsernameUseCase,
    required this._accountsUsecase,
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
      final accounts = await _accountsUsecase.execute(user.id.value);
      AuthUserController.to.setUser(user);
      AuthAccountsController.to.setAccount(accounts);
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
