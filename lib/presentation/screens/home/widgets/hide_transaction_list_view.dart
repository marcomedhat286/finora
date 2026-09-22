import 'package:finora/core/constants.dart';
import 'package:finora/presentation/controller/auth_transactions_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HideTransactionListView extends StatelessWidget {
  const HideTransactionListView({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionsController = AuthTransactionsController.to;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: 35,
        child: Row(
          children: [
            Text(
              "All Transactions (${transactionsController.transactionLength})",
              style: const TextStyle(
                color: kPrimaryColor2,
                fontSize: smallSizeFont,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(flex: 1),

            IconButton(
              onPressed: () {},
              icon: FaIcon(
                FontAwesomeIcons.ellipsis,
                color: kPrimaryColor,
                size: smallSizeFont * 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
