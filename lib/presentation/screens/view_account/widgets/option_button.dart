import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/view_account/view_model/update_delete_account_controller.dart';
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
            await showConfirmMessage(controller);
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

  Future<void> showConfirmMessage(
    UpdateDeleteAccountController controller,
  ) async {
    const style = TextStyle(color: kPrimaryColor, fontWeight: .bold);
    final result = await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: kPrimaryColor3,
        title: const Text('Confirm', style: style),
        content: const Text(
          "If u delete this account, you will also delete all its transactions. "
          "Are you sure you want to delete this account?",
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel', style: style),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              fixedSize: const Size(150, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Delete',
              style: TextStyle(color: kSecondColor, fontWeight: .bold),
            ),
          ),
        ],
      ),
    );

    if (result == true) {
      await controller.sumbitDelete();
    }
  }
}
