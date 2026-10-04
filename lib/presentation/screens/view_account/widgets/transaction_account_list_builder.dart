import 'package:finora/presentation/screens/home/widgets/not_found_account_or_transaction.dart';
import 'package:finora/presentation/screens/home/widgets/transaction_card.dart';
import 'package:finora/presentation/screens/view_account/view_model/get_list_view_account_transactoin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionAccountListBuilder extends StatelessWidget {
  const TransactionAccountListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GetListViewAccountTransactoinController>();
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Obx(() {
          if (controller.recentTransactions.isEmpty) {
            return const NotFoundAccountOrTransaction(message: null);
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.recentTransactions.length,
            itemBuilder: (context, index) {
              final transaction = controller.recentTransactions[index];
              return TransactionCard(transaction: transaction);
            },
          );
        }),
      ),
    );
  }
}
