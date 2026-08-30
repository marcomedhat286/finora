import 'package:finora/data/repositories/isar_user_repository.dart';
import 'package:finora/domain/repositories/account_repository.dart';
import 'package:finora/domain/usecases/account/create_account_usecase.dart';
import 'package:finora/domain/usecases/user/create_user_usecase.dart';
import 'package:finora/presentation/screens/sign_up/view_model/sign_up_view_model.dart';
import 'package:get/get.dart';
import 'package:isar_community/isar.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpViewModel>(
      () => SignUpViewModel(
        createNewUser: CreateUserUseCase(
          userRepository: IsarUserRepository(Get.find<Isar>()),
        ),
        createAccountUseCase: CreateAccountUseCase(
          accountRepository: AccountRepository(),
        ),
      ),
    );
  }
}
