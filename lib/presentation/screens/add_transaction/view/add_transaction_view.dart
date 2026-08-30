import 'package:finora/presentation/screens/add_transaction/widgets/add_transaction_body.dart';
import 'package:flutter/material.dart';

enum TransactionType { income, expense }

class AddTransactionView extends StatelessWidget {
  const AddTransactionView({super.key, required this._type});
  final TransactionType _type;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AddTransactionBody(type: _type));
  }
}
