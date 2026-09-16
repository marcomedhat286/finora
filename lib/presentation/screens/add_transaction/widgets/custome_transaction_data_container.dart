import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/add_transaction/widgets/transaction_data_feilds.dart';
import 'package:flutter/material.dart';

enum TransactionType { income, expense }

class CustomeTransactionDataContainer extends StatelessWidget {
  const CustomeTransactionDataContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.bottomCenter,
      child: Container(
        height: 570,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: const BoxDecoration(
          color: kSecondColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: blurRadius,
              spreadRadius: 5,
              offset: Offset(0, 15),
            ),
          ],
        ),
        child: const TransactionDataFeilds(),
      ),
    );
  }
}
