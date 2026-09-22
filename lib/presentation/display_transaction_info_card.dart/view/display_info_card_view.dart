import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/presentation/display_transaction_info_card.dart/widgets/display_transaction_info_card_body.dart';
import 'package:flutter/material.dart';

class DisplayInfoCardView extends StatelessWidget {
  const DisplayInfoCardView({super.key, required this._transaction});
  final Transaction _transaction;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        height: double.infinity,
        child: DisplayInfoCardBody(transaction: _transaction),
      ),
    );
  }
}
