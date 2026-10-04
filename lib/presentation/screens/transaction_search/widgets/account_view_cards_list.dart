import 'package:finora/domain/value_object/account/account_potions.dart';
import 'package:finora/presentation/controller/auth_accounts_controller.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/account_option_view_card.dart';
import 'package:flutter/material.dart';

class AccountViewCardsList extends StatelessWidget {
  const AccountViewCardsList({super.key});
  @override
  Widget build(BuildContext context) {
    final accountsOption = AuthAccountsController.to.userAccounts
        .map(
          (account) => AccountOption(
            accountId: account.id.value,
            accountName: account.name.value,
            amount: account.currentBalance.value,
            accountType: account.type,
          ),
        )
        .toList();
    accountsOption.insert(0, AccountOption.all());
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: ListView.builder(
          itemCount: accountsOption.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final account = accountsOption[index];
            return AccountOptionViewCard(account: account);
          },
        ),
      ),
    );
  }
}
