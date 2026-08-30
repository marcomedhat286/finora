import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/add_account/view_model/add_account_controller.dart';
import 'package:finora/presentation/controller/auth_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddAccountButton extends StatelessWidget {
  final controller = Get.find<AddAccountController>();
  AddAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthUserController.to.currentUser;
    if (user == null) return SizedBox();
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: ElevatedButton(
        onPressed: () async {
          await controller.sumbitCreateNewAccount(user);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          fixedSize: const Size(230, 40),
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
            "create New Account",
            style: TextStyle(color: kSecondColor, fontSize: smallSizeFont),
            textAlign: TextAlign.center,
          );
  }
}
