import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/add_transaction/view/add_transaction_view.dart';
import 'package:finora/presentation/screens/add_transaction/view_model/add_transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddTransactionButton extends StatelessWidget {
  final controller = Get.find<AddTransactionController>();
  AddTransactionButton({super.key, required this._type});
  final TransactionType _type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: ElevatedButton(
        onPressed: () async {
          switch (_type) {
            case TransactionType.Income:
              await controller.sumbitAddIncome();
              break;
            case TransactionType.Expense:
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
            "add",
            style: TextStyle(color: kSecondColor, fontSize: smallSizeFont),
            textAlign: TextAlign.center,
          );
  }
}
