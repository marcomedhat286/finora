import 'package:finora/data/repositories/isar_account_repository.dart';
import 'package:finora/data/repositories/isar_transaction_repository.dart';
import 'package:finora/data/repositories/isar_user_repository.dart';
import 'package:finora/domain/usecases/account/get_accounts_usecase.dart';
import 'package:finora/domain/usecases/transaction/get_transaction_usecase.dart';
import 'package:finora/domain/usecases/user/get_user_usecase.dart';
import 'package:finora/presentation/screens/login/view_model/login_controller.dart';
import 'package:get/instance_manager.dart';
import 'package:isar_community/isar.dart';

class LoginDependence extends Bindings {
  @override
  void dependencies() {
    final isarInstance = Get.find<Isar>();
    Get.lazyPut<LoginController>(
      () => LoginController(
        getUserByUsernameUseCase: GetUserByUsernameUseCase(
          userRepository: IsarUserRepository(isarInstance),
        ),
        getAccountsUsecase: GetAccountsUsecase(
          IsarAccountRepository(isarInstance),
        ),
        getTransactionUsecase: GetTransactionUsecase(
          transactionRepository: IsarTransactionRepository(isar: isarInstance),
        ),
      ),
    );
  }
}
