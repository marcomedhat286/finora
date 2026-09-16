import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/add_transaction/view_model/add_transaction_controller.dart';
import 'package:finora/presentation/screens/add_transaction/widgets/custome_transaction_data_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddTransactionButton extends StatelessWidget {
  const AddTransactionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddTransactionController>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: ElevatedButton(
        onPressed: () async {
          switch (controller.selectedType.value) {
            case TransactionType.income:
              await controller.sumbitAddIncome();
              break;
            case TransactionType.expense:
              await controller.sumbitAddExpense();
              break;
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          fixedSize: const Size(250, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Obx(() => _returnButtonState(controller)),
      ),
    );
  }

  Widget _returnButtonState(AddTransactionController controller) {
    return (controller.isLoading.value)
        ? LoadingAnimationWidget.staggeredDotsWave(
            color: kSecondColor,
            size: 30,
          )
        : Text(
            "add ${controller.selectedType.value.name}".toUpperCase(),
            style: const TextStyle(
              color: kSecondColor,
              fontSize: smallSizeFont,
            ),
            textAlign: TextAlign.center,
          );
  }
}
