import 'package:finora/presentation/screens/transaction_search/widgets/account_view_cards_list.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/head_selected_option.dart';
import 'package:flutter/material.dart';

class AccountOptionsUiBody extends StatelessWidget {
  const AccountOptionsUiBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        HeadSelectedOption(SelectedOptionName: "Select Account"),
        AccountViewCardsList(),
      ],
    );
  }
}
