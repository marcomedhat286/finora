import 'package:finora/core/constants.dart';
import 'package:finora/presentation/controller/auth_user_controller.dart';
import 'package:finora/presentation/screens/display_all_accounts/widgets/gradient_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllUserAccountsCard extends StatelessWidget {
  const AllUserAccountsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final accounts = AuthUserController.to.userAccounts;
      final defualtAccount = AuthUserController.to.defaultAccount;
      if (defualtAccount == null) return const SizedBox();
      if (accounts.isEmpty) return const SizedBox();
      return Align(
        alignment: AlignmentGeometry.xy(0, 0.9),
        child: SizedBox(
          height: 600,
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
                  title: account.name.value,
                  type: account.type.displayName,
                  currentBalance: "${account.currentBalance.value}",
                  accountId: account.id.value,
                  createdAt: account.createdAt,
                  colors: cardPalettes[index],
                  isDefault: account == defualtAccount,
                );
              },
            ),
          ),
        ),
      );
    });
  }
}
