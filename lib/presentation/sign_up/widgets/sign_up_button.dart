import 'package:finora/core/constants.dart';
import 'package:finora/domain/repositories/user_repository.dart';

import 'package:finora/domain/use_cases/register_user_use_case.dart';
import 'package:finora/presentation/sign_up/view_model/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignUpButton extends StatelessWidget {
  final SignUpViewModel controller = Get.put(
    SignUpViewModel(
      signUpUserUseCase: RegisterUserUseCase(userRepository: UserRepository()),
    ),
  );
  SignUpButton({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.userName,
    required this.balance,
  });

  final TextEditingController firstName;
  final TextEditingController lastName;
  final TextEditingController middleName;
  final TextEditingController userName;
  final TextEditingController balance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: ElevatedButton(
        onPressed: () async {
          await controller.submitSignUp(
            user_name: (userName.text.isEmpty) ? null : userName.text,
            firstName: firstName.text,
            middleName: (middleName.text.isEmpty) ? null : middleName.text,
            lastName: (lastName.text.isEmpty) ? null : lastName.text,
            initialBalance: balance.text,
          );
        },

        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          fixedSize: const Size(250, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Obx(() => _returnButtonState),
      ),
    );
  }

  Widget get _returnButtonState {
    return (controller.isLoading.value)
        ? LoadingAnimationWidget.staggeredDotsWave(
            color: kSecondColor,
            size: 30,
          )
        : const Text(
            "Sign Up",
            style: TextStyle(color: kSecondColor, fontSize: smallSizeFont),
            textAlign: TextAlign.center,
          );
  }
}
