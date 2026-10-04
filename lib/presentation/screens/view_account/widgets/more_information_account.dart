import 'package:finora/presentation/screens/view_account/view_model/get_list_view_account_transactoin_controller.dart';
import 'package:finora/presentation/screens/view_account/widgets/see_more_button.dart';
import 'package:finora/presentation/screens/view_account/widgets/total_income_expense_card.dart';
import 'package:finora/presentation/screens/view_account/widgets/transaction_account_list_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoreInformationAccount extends StatelessWidget {
  const MoreInformationAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GetListViewAccountTransactoinController>();
    return Obx(
      () => (controller.showTransactions.value)
          ? Column(
              children: [
                const TotalIncomeExpenseCard(),
                const SizedBox(height: 5),
                const TransactionAccountListBuilder(),
                (controller.allAccountTransaction.value > 5)
                    ? const SeeMoreButton()
                    : const SizedBox(),
              ],
            )
          : const SizedBox(height: 50),
    );
  }
}
