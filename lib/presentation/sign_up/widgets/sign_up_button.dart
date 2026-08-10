import 'package:finora/core/constants.dart';
import 'package:finora/presentation/sign_up/view_model/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignUpButton extends StatelessWidget {
  final controller = Get.find<SignUpViewModel>();
  SignUpButton({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.userName,
    required this.balance,
    required this.birthDate,
  });

  final TextEditingController firstName;
  final TextEditingController lastName;
  final TextEditingController middleName;
  final TextEditingController userName;
  final TextEditingController balance;
  final DateTime? birthDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: ElevatedButton(
        onPressed: () async {
          await controller.submitSignUp(
            firstName: firstName.text.trim(),
            initialBalance: balance.text.trim(),
            birthDate: birthDate,
            user_name: (userName.text.isEmpty) ? null : userName.text.trim(),

            middleName: (middleName.text.isEmpty)
                ? null
                : middleName.text.trim(),
            lastName: (lastName.text.isEmpty) ? null : lastName.text.trim(),
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
