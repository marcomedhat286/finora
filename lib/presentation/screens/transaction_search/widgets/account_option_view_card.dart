import 'package:finora/core/constants.dart';
import 'package:finora/domain/value_object/account/account_potions.dart';
import 'package:finora/presentation/extensions/category_account_ui_extension.dart';
import 'package:finora/presentation/screens/transaction_search/view_model/flitter_search_transactions_controller.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/option_icon.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/account_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountOptionViewCard extends StatelessWidget {
  const AccountOptionViewCard({super.key, required this.account});

  final AccountOption account;

  @override
  Widget build(BuildContext context) {
    final flitterSearchController =
        Get.find<FlitterSearchTransactionsController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Obx(() {
              final bool isAllOption = account.accountId == null;

              final bool isSelected = isAllOption
                  ? flitterSearchController.isAllSelected
                  : flitterSearchController.isAccountSelected(
                      account.accountId,
                    );

              flitterSearchController.isAllSelected;
              return Checkbox(
                value: isSelected,
                activeColor: kPrimaryColor2,
                onChanged: (value) {
                  if (value == null) return;
                  final accountId = account.accountId;

                  if (accountId == null) {
                    if (value) {
                      flitterSearchController.addAllSelectedAccounts();
                    } else {
                      flitterSearchController.removeAllAccounts();
                    }
                  } else {
                    if (value) {
                      flitterSearchController.addAccountOption(accountId);
                    } else {
                      flitterSearchController.removeAccountOption(accountId);
                    }
                  }
                },
              );
            }),
            OptionIcon(icon: account.icon, color: account.iconColor),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
                child: AccountInfo(
                  accountName: account.accountName,
                  accountCurrentBalacne: account.amount,
                  accountType: account.accountType?.displayName,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
