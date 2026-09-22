import 'package:finora/core/constants.dart';
import 'package:finora/presentation/controller/auth_transactions_controller.dart';
import 'package:finora/presentation/screens/home/view_model.dart/view_transaction_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HideMoreTransactionsStateButton extends StatelessWidget {
  const HideMoreTransactionsStateButton({super.key});

  @override
  Widget build(BuildContext context) {
    final viewTxController = Get.find<ViewTransactionController>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 100.0),
      child: TextButton(
        onPressed: () {
          viewTxController.removeMoreTransaction();
        },
        child: Obx(
          () => Text(
            "Hide the last (${getNumberOfLastTransactions(viewTxController)}) Transactions",
            style: const TextStyle(
              color: kPrimaryColor2,
              fontSize: smallSizeFont,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  int getNumberOfLastTransactions(ViewTransactionController controller) {
    return controller.recentTransactions.length -
        AuthTransactionsController.to.userTransactions.length;
  }
}
