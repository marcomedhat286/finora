import 'package:finora/core/constants.dart';
import 'package:finora/presentation/controller/auth_transactions_controller.dart';
import 'package:finora/presentation/screens/home/view_model.dart/view_transaction_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetTransactionsStateButton extends StatelessWidget {
  const SetTransactionsStateButton({super.key});

  @override
  Widget build(BuildContext context) {
    final viewTxController = Get.find<ViewTransactionController>();
    return Obx(() {
      if (AuthTransactionsController.to.transactionLength > 5) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: TextButton(
            onPressed: () async {
              await viewTxController.setRecentTransactionsStateAction();
            },
            child: Text(
              (!viewTxController.hideState.value)
                  ? "See All (${_getNumberOfLastTransactions(viewTxController)}) Transactions"
                        .toUpperCase()
                  : "Hide All Transaction".toUpperCase(),
              style: const TextStyle(
                color: kPrimaryColor2,
                fontSize: smallSizeFont,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }
      return SizedBox.shrink();
    });
  }

  int _getNumberOfLastTransactions(ViewTransactionController viewTxController) {
    return AuthTransactionsController.to.transactionLength.value -
        viewTxController.recentTransactions.length;
  }
}
