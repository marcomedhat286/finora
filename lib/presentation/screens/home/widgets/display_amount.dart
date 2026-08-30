import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/presentation/controller/auth_user_controller.dart';
import 'package:flutter/material.dart';

class DisplayAmount extends StatelessWidget {
  const DisplayAmount({
    super.key,
    required this.isIncome,
    required this.transaction,
  });

  final bool isIncome;
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final assiostedAccount = AuthUserController.to.getByAccountId(
      transaction.accountId,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '${isIncome ? '+' : '-'}${transaction.amount}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isIncome ? Colors.green : Colors.red,
          ),
        ),

        const SizedBox(height: 4),

        const Text('EGP', style: TextStyle(fontSize: 11, color: Colors.grey)),
        Text(assiostedAccount.name.value, style: TextStyle(fontSize: 11)),
        Text(
          accountIdFormat,
          style: TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ],
    );
  }

  String get accountIdFormat => transaction.accountId.value.split("-").last;
}
