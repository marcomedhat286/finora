import 'package:finora/core/constants.dart';
import 'package:finora/presentation/view_account/view_model/update_delete_account_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OptionButton extends StatelessWidget {
  final String option;
  const OptionButton({super.key, required this.option});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UpdateDeleteAccountController>();
    return ElevatedButton(
      onPressed: () async {
        switch (option) {
          case "update":
            await controller.sumbitUpdate();
            break;
          case "delete":
            await controller.sumbitDelete();
            break;
          default:
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        fixedSize: const Size(150, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Obx(
        () => _returnButtonState(controller: controller, option: option),
      ),
    );
  }

  Widget _returnButtonState({
    required UpdateDeleteAccountController controller,
    required String option,
  }) {
    return (controller.isLoading.value)
        ? LoadingAnimationWidget.staggeredDotsWave(
            color: kSecondColor,
            size: 30,
          )
        : Text(
            option,
            style: const TextStyle(
              color: kSecondColor,
              fontSize: smallSizeFont,
            ),
            textAlign: TextAlign.center,
          );
  }
}
