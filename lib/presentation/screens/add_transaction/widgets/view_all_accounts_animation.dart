import 'package:finora/core/constants.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/presentation/screens/add_transaction/view_model/add_transaction_controller.dart';
import 'package:finora/presentation/screens/display_all_accounts/widgets/gradient_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewAllAccountsAnimation extends StatelessWidget {
  const ViewAllAccountsAnimation({
    super.key,
    required this.controller,
    required this.accounts,
  });

  final AddTransactionController controller;
  final List<Account> accounts;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: controller.isExpanded.value
            ? Column(
                children: [
                  const SizedBox(height: 8),

                  ...List.generate(accounts.length, (index) {
                    final account = accounts[index];

                    if (account.id == controller.selectedAccount.value!.id) {
                      return const SizedBox.shrink();
                    }
                    return GradientCard(
                      title: account.name.value,
                      type: account.type.displayName,
                      currentBalance: "${account.currentBalance.value}",
                      accountId: account.id.value,
                      createdAt: account.createdAt,
                      colors: cardPalettes[index % cardPalettes.length],
                      onTap: () {
                        controller.isExpanded.value = false;
                        controller.selectedAccount.value = account;
                      },
                    );
                  }),
                ],
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
