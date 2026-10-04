import 'package:finora/presentation/screens/home/view_model.dart/view_transaction_view_controller.dart';
import 'package:finora/presentation/screens/home/widgets/not_found_account_or_transaction.dart';
import 'package:finora/presentation/screens/home/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionListBuilder extends StatelessWidget {
  const TransactionListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final viewTxController = Get.find<ViewTransactionController>();
    return Obx(() {
      final transactions = viewTxController.recentTransactions;
      if (transactions.isEmpty) {
        return const NotFoundAccountOrTransaction(message: null);
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return TransactionCard(transaction: transaction);
        },
      );
    });
  }
}
