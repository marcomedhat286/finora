import 'package:finora/core/constants.dart';
import 'package:finora/presentation/controller/auth_transactions_controller.dart';
import 'package:finora/presentation/screens/home/view_model.dart/view_transaction_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetAllTransactionsStateButton extends StatelessWidget {
  const GetAllTransactionsStateButton({super.key});

  @override
  Widget build(BuildContext context) {
    final viewTxController = Get.find<ViewTransactionController>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 100.0),
      child: TextButton(
        onPressed: () async {
          await viewTxController.getMoreTransaction();
        },
        child: Obx(
          () => Text(
            "See All ($_getNumberOfLastTransactions) Transactions",
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

  int get _getNumberOfLastTransactions {
    return AuthTransactionsController.to.transactionLength.value -
        AuthTransactionsController.to.userTransactions.length;
  }
}
