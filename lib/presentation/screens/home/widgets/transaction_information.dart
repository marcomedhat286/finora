import 'package:finora/core/constants.dart';
import 'package:finora/domain/entities/transaction.dart';
import 'package:flutter/material.dart';

class TransactionInformation extends StatelessWidget {
  const TransactionInformation({super.key, required this.transaction});
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            transaction.category.displayName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: kPrimaryColor2,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            transaction.title.value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: kPrimaryColor.withAlpha(alphaValue * 4),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            _formatDate(transaction.createdAt),
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }
}
