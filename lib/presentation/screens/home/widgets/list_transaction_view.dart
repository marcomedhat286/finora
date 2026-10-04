import 'package:finora/presentation/screens/home/widgets/set_transactions_state_button.dart';

import 'package:finora/presentation/screens/home/widgets/head_transaction_list_view.dart';
import 'package:finora/presentation/screens/home/widgets/transaction_list_builder.dart';
import 'package:flutter/material.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        HeadTransactionListView(),
        SizedBox(
          height: 300,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TransactionListBuilder(),
                SetTransactionsStateButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
