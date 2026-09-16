import 'package:finora/presentation/screens/add_transaction/view_model/add_transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropAccountsButton extends StatelessWidget {
  const DropAccountsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddTransactionController>();
    return GestureDetector(
      onTap: () {
        controller.isExpanded.value = !controller.isExpanded.value;
      },
      child: Obx(
        () => AnimatedRotation(
          duration: const Duration(milliseconds: 200),
          turns: controller.isExpanded.value ? 0.5 : 0,
          child: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.grey,
            size: 30,
          ),
        ),
      ),
    );
  }
}
