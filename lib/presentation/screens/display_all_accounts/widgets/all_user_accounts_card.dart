import 'package:finora/core/constants.dart';
import 'package:finora/presentation/controller/auth_accounts_controller.dart';
import 'package:finora/presentation/screens/display_all_accounts/widgets/gradient_card.dart';
import 'package:finora/presentation/screens/home/widgets/not_found_account_or_transaction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllUserAccountsCard extends StatelessWidget {
  const AllUserAccountsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final accounts = AuthAccountsController.to.userAccounts;
      if (accounts.isEmpty) {
        return const PositionedDirectional(
          top: 350,
          start: 60,
          child: NotFoundAccountOrTransaction(message: null, name: "Accounts"),
        );
      }
      return Align(
        alignment: AlignmentGeometry.xy(0, 1),
        child: SizedBox(
          height: 570,
          child: ListWheelScrollView.useDelegate(
            itemExtent: 250,
            perspective: 0.003,
            diameterRatio: 2.5,
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: accounts.length,
              builder: (context, index) {
                final account = accounts[index];
                return GradientCard(
                  account: account,
                  title: account.name.value,
                  type: account.type.displayName,
                  currentBalance: "${account.currentBalance.value}",
                  accountId: account.id.value,
                  createdAt: account.createdAt,
                  colors: cardPalettes[index % cardPalettes.length],
                  isDefault: account.isDefault,
                );
              },
            ),
          ),
        ),
      );
    });
  }
}
