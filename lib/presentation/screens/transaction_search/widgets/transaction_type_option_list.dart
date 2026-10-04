import 'package:finora/domain/enum/transaction/transaction_type_option.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/transaction_type_option_card.dart';
import 'package:flutter/material.dart';

class TransactionTypeOptionList extends StatelessWidget {
  const TransactionTypeOptionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: TransactionTypeOptions.values.length,
        itemBuilder: (context, index) {
          final option = TransactionTypeOptions.values[index];
          return TransactionTypeOptionCard(typeOption: option);
        },
      ),
    );
  }
}
