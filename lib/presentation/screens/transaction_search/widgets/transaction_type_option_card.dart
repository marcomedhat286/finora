import 'package:finora/core/constants.dart';
import 'package:finora/domain/enum/transaction/transaction_type_option.dart';
import 'package:finora/presentation/extensions/category_transaction_type_ui_extension.dart';
import 'package:finora/presentation/screens/transaction_search/view_model/flitter_search_transactions_controller.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/option_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionTypeOptionCard extends StatelessWidget {
  const TransactionTypeOptionCard({super.key, required this.typeOption});

  final TransactionTypeOptions typeOption;

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
              final isSelected = flitterSearchController
                  .isEqualToTransactionTypeOption(typeOption);
              return Checkbox(
                value: isSelected,
                activeColor: kPrimaryColor2,
                onChanged: (value) {
                  if (value == null) return;
                  if (value) {
                    flitterSearchController.updateTransactionType(typeOption);
                  }
                },
              );
            }),
            OptionIcon(icon: typeOption.icon, color: typeOption.color),

            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
                child: Text(
                  typeOption.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: smallSizeFont,
                    fontWeight: .bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
