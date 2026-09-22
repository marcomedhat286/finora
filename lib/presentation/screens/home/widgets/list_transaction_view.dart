import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/presentation/controller/auth_transactions_controller.dart';
import 'package:finora/presentation/screens/home/view_model.dart/view_transaction_view_controller.dart';
import 'package:finora/presentation/screens/home/widgets/get_all_transactions_state_button.dart';
import 'package:finora/presentation/screens/home/widgets/hide_more_transactions_state_button.dart';
import 'package:finora/presentation/screens/home/widgets/hide_transaction_list_view.dart';
import 'package:finora/presentation/screens/home/widgets/no_transaction_text_widget.dart';
import 'package:finora/presentation/screens/home/widgets/transaction_list_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    final viewTxController = Get.find<ViewTransactionController>();
    final transactionsController = AuthTransactionsController.to;
    return Obx(() {
      transactionsController.updateState((callback) {
        viewTxController.recentTransactions.clear();
      });
      if (transactionsController.userTransactions.isEmpty) {
        return const NoTransactionTextWidget();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          HideTransactionListView(),
          SizedBox(
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TransactionListBuilder(
                    userTransactions: transactionListState(
                      viewTxController,
                      transactionsController,
                    ),
                  ),
                  GetViewTransactionButtonState(
                    transactionsController,
                    viewTxController,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget GetViewTransactionButtonState(
    AuthTransactionsController transactionsController,
    ViewTransactionController viewTxController,
  ) {
    return (transactionsController.transactionLength > 5 &&
            viewTxController.recentTransactions.isEmpty)
        ? const GetAllTransactionsStateButton()
        : (transactionsController.transactionLength > 5 &&
              viewTxController.recentTransactions.isNotEmpty)
        ? const HideMoreTransactionsStateButton()
        : const SizedBox.shrink();
  }

  List<Transaction> transactionListState(
    ViewTransactionController recentController,
    AuthTransactionsController transactionController,
  ) {
    if (recentController.recentTransactions.isNotEmpty) {
      return recentController.recentTransactions;
    } else {
      return transactionController.userTransactions;
    }
  }
}
