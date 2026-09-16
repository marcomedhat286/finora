import 'package:finora/core/constants.dart';
import 'package:finora/presentation/controller/auth_accounts_controller.dart';
import 'package:finora/presentation/screens/add_transaction/view_model/add_transaction_controller.dart';
import 'package:finora/presentation/screens/add_transaction/widgets/choose_account_hide.dart';
import 'package:finora/presentation/screens/add_transaction/widgets/view_all_accounts_animation.dart';
import 'package:finora/presentation/screens/add_transaction/widgets/view_selected_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountDropdownSelector extends StatelessWidget {
  const AccountDropdownSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddTransactionController>();
    final accounts = AuthAccountsController.to.userAccounts;
    return accounts.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ChooseAccountHide(),
              ViewSelectedAccount(accounts: accounts),
              ViewAllAccountsAnimation(
                controller: controller,
                accounts: accounts,
              ),
            ],
          )
        : Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
            child: Text(
              "There is no accounts to make transaction, must create new one to do it.",
              style: TextStyle(
                fontSize: smallSizeFont,
                fontWeight: .bold,
                color: Colors.redAccent.shade700,
              ),
            ),
          );
  }
}
