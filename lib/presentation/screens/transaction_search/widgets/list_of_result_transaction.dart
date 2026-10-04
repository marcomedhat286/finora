import 'package:finora/presentation/screens/home/widgets/not_found_account_or_transaction.dart';
import 'package:finora/presentation/screens/home/widgets/transaction_card.dart';
import 'package:finora/presentation/screens/transaction_search/view_model/flitter_search_transactions_controller.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/start_search_certira_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListOfResultTransaction extends StatelessWidget {
  const ListOfResultTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    final flitterController = Get.find<FlitterSearchTransactionsController>();
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Obx(() {
          if (flitterController.isStartedSearch.value) {
            if (flitterController.result.isEmpty) {
              return const NotFoundAccountOrTransaction(
                message: "Try Adjusting your search criteria or flitters",
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: flitterController.result.length,
              itemBuilder: (context, index) {
                final transaction = flitterController.result[index];
                return TransactionCard(transaction: transaction);
              },
            );
          } else {
            return StartSearchCertiraWidget();
          }
        }),
      ),
    );
  }
}
