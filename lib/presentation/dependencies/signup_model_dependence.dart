import 'package:finora/domain/repositories/account_repository.dart';
import 'package:finora/domain/repositories/user_repository.dart';
import 'package:finora/domain/usecases/account/create_account_usecase.dart';
import 'package:finora/domain/usecases/user/create_user_usecase.dart';
import 'package:finora/presentation/sign_up/view_model/sign_up_view_model.dart';
import 'package:get/get.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpViewModel>(
      () => SignUpViewModel(
        createNewUser: CreateUserUseCase(userRepository: UserRepository()),
        createAccountUseCase: CreateAccountUseCase(
          accountRepository: AccountRepository(),
        ),
      ),
    );
  }
}
