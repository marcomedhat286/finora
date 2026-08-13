import 'package:finora/domain/repositories/user_repository.dart';
import 'package:finora/domain/use_cases/register_new_user_use_case.dart';
import 'package:finora/presentation/sign_up/view_model/sign_up_view_model.dart';
import 'package:finora/presentation/sign_up/widgets/custome_sign_up_data_container.dart';
import 'package:finora/presentation/sign_up/widgets/many_circles_container.dart';
import 'package:finora/presentation/sign_up/widgets/welcome_message_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(
      SignUpViewModel(
        signUpUserUseCase: RegisterUserUseCase.RegisterNewUserUseCase(
          userRepository: UserRepository(),
        ),
      ),
    );
    return const Stack(
      children: [
        ManyCirclesContainer(body: WelcomeMessageForSignUp()),
        CustomeSignUpDataContainer(),
      ],
    );
  }
}
