import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/add_transaction/view_model/add_transaction_controller.dart';
import 'package:finora/presentation/screens/add_transaction/widgets/custome_transaction_data_container.dart';
import 'package:finora/presentation/screens/add_transaction/widgets/type_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectTypeTransaction extends StatelessWidget {
  const SelectTypeTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddTransactionController>();
    return Container(
      height: 50,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
      decoration: BoxDecoration(
        color: cardPalettes[1][2],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Expanded(
              child: TypeButton(
                title: 'Income',
                icon: Icons.arrow_downward_rounded,
                isSelected:
                    controller.selectedType.value == TransactionType.income,
                onTap: () {
                  controller.selectedType.value = TransactionType.income;
                },
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TypeButton(
                title: 'Expense',
                icon: Icons.arrow_upward_rounded,
                isSelected:
                    controller.selectedType.value == TransactionType.expense,
                onTap: () {
                  controller.selectedType.value = TransactionType.expense;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
