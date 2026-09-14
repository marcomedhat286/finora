import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/login/view_model/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    return ElevatedButton(
      onPressed: () async {
        await controller.sumbitLogin();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        fixedSize: const Size(200, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Obx(() => _returnButtonState(controller)),
    );
  }

  Widget _returnButtonState(LoginController controller) {
    return (controller.isLoading.value)
        ? LoadingAnimationWidget.staggeredDotsWave(
            color: kSecondColor,
            size: 30,
          )
        : const Text(
            "Login",
            style: TextStyle(color: kSecondColor, fontSize: smallSizeFont),
            textAlign: TextAlign.center,
          );
  }
}
