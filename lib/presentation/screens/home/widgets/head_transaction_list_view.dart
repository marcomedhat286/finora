import 'package:finora/core/constants.dart';
import 'package:finora/presentation/controller/auth_transactions_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeadTransactionListView extends StatelessWidget {
  const HeadTransactionListView({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionsController = AuthTransactionsController.to;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: 35,
        child: Row(
          children: [
            Obx(
              () => Text(
                "All Transactions (${transactionsController.transactionLength})",
                style: const TextStyle(
                  color: kPrimaryColor2,
                  fontSize: smallSizeFont,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
