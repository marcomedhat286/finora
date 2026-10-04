import 'package:finora/core/constants.dart';
import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/domain/enum/transaction/income_category.dart';
import 'package:finora/presentation/core/show_dialog.dart';
import 'package:finora/presentation/display_transaction_info_card.dart/widgets/display_transaction_info_card_body.dart';
import 'package:finora/presentation/screens/home/widgets/category_icon.dart';
import 'package:finora/presentation/screens/home/widgets/display_amount.dart';
import 'package:finora/presentation/screens/home/widgets/transaction_information.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.category.runtimeType == IncomeCategory;

    return InkWell(
      onTap: () async {
        await ShowDialog.showFlitterOptionsDialog(
          buildContext: context,
          body: DisplayInfoCardBody(transaction: transaction),
          ratio: 0.75,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: kSecondColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CategoryIcon(category: transaction.category),

            const SizedBox(width: 14),

            TransactionInformation(transaction: transaction),

            // Amount
            DisplayAmount(isIncome: isIncome, transaction: transaction),
          ],
        ),
      ),
    );
  }
}
