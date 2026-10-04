import 'package:finora/presentation/screens/transaction_search/widgets/head_selected_option.dart';

import 'package:finora/presentation/screens/transaction_search/widgets/transaction_type_option_list.dart';
import 'package:flutter/material.dart';

class TransactionOptionsUiBody extends StatelessWidget {
  const TransactionOptionsUiBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeadSelectedOption(SelectedOptionName: "Transaction Type"),
        const TransactionTypeOptionList(),
      ],
    );
  }
}
