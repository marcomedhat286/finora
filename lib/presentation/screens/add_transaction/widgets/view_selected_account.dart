import 'package:finora/core/constants.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/presentation/screens/add_transaction/view_model/add_transaction_controller.dart';
import 'package:finora/presentation/screens/display_all_accounts/widgets/gradient_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewSelectedAccount extends StatelessWidget {
  const ViewSelectedAccount({super.key, required this.accounts});
  final List<Account> accounts;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddTransactionController>();
    if (controller.selectedAccount.value == null) {
      return const SizedBox.shrink();
    }
    return Obx(
      () => GradientCard(
        title: controller.selectedAccount.value!.name.value,
        type: controller.selectedAccount.value!.type.displayName,
        currentBalance:
            "${controller.selectedAccount.value!.currentBalance.value}",
        accountId: controller.selectedAccount.value!.id.value,
        createdAt: controller.selectedAccount.value!.createdAt,
        colors:
            cardPalettes[accounts.indexOf(controller.selectedAccount.value!) %
                cardPalettes.length],
        onTap: () {
          controller.isExpanded.value = !controller.isExpanded.value;
        },
      ),
    );
  }
}
