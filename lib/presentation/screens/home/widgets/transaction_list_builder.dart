import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/presentation/screens/home/widgets/transaction_card.dart';
import 'package:flutter/material.dart';

class TransactionListBuilder extends StatelessWidget {
  const TransactionListBuilder({super.key, required this.userTransactions});

  final List<Transaction> userTransactions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: userTransactions.length,
      itemBuilder: (context, index) {
        final transaction = userTransactions[index];
        return TransactionCard(transaction: transaction);
      },
    );
  }
}
