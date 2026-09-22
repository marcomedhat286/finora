import 'package:finora/core/constants.dart';
import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/presentation/display_transaction_info_card.dart/widgets/transaction_icon.dart';
import 'package:finora/presentation/display_transaction_info_card.dart/widgets/transaction_information_container.dart';
import 'package:flutter/material.dart';

class DisplayInfoCardBody extends StatelessWidget {
  const DisplayInfoCardBody({super.key, required this._transaction});

  final Transaction _transaction;

  @override
  Widget build(BuildContext context) {
    final colors = cardPalettesMap["primaryCardBalance"]?.sublist(0, 2);
    colors?.add(Colors.white);
    return Align(
      alignment: AlignmentGeometry.xy(0, -0.3),
      child: Container(
        width: double.infinity,
        height: 600,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: colors ?? defaultColors,
            transform: const GradientRotation(-0.75),
            stops: [0.3, 0.7, 0.9],
            begin: .topRight,
            end: .centerLeft,
          ),
          boxShadow: const [
            BoxShadow(
              blurRadius: 50,
              color: Colors.blueGrey,
              offset: Offset.zero,
            ),
          ],
        ),

        child: Column(
          children: [
            TransactionIcon(categoryType: _transaction.category),
            const SizedBox(height: 10),
            TransactionInformationContainer(transaction: _transaction),
          ],
        ),
      ),
    );
  }
}
