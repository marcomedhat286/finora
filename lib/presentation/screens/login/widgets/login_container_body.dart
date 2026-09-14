import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/login/view_model/login_controller.dart';
import 'package:finora/presentation/screens/login/widgets/login_button.dart';
import 'package:finora/presentation/screens/login/widgets/sign_up_now.dart';
import 'package:finora/presentation/screens/sign_up/widgets/custome_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginContainerBody extends StatelessWidget {
  const LoginContainerBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 15),
        Obx(
          () => CustomeTextField(
            dataName: "username",
            hinitMessage: "EG. username_123",
            prefixIcon: Icons.abc,
            textEditingController: controller.userNameController,
            errorText: controller.userNameError.value,
            borderColor: kSecondColor,
          ),
        ),
        const LoginButton(),
        const SignUpNow(),
      ],
    );
  }
}
