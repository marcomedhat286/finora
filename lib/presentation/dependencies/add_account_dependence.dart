import 'package:finora/domain/repositories/account_repository.dart';
import 'package:finora/domain/usecases/account/create_account_usecase.dart';
import 'package:finora/presentation/screens/add_account/view_model/add_account_controller.dart';
import 'package:get/instance_manager.dart';

class AddAccountDependence extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddAccountController>(
      () => AddAccountController(
        createAccount: CreateAccountUseCase(
          accountRepository: AccountRepository(),
        ),
      ),
    );
  }
}
