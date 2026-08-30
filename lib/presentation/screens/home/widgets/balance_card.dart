import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/display_all_accounts/widgets/card_design_painter.dart';
import 'package:finora/presentation/screens/home/widgets/display_expense.dart';
import 'package:finora/presentation/screens/home/widgets/display_income.dart';

import 'package:finora/presentation/screens/home/widgets/total_balance.dart';
import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 180.0),
      child: Container(
        height: 220,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        // padding: const EdgeInsets.all(30),
        isAntiAlias: false,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: kPrimaryColor2,
          boxShadow: const [
            BoxShadow(
              blurRadius: blurRadius,
              color: kPrimaryColor,
              spreadRadius: 2,
            ),
          ],
          gradient: RadialGradient(
            center: AlignmentGeometry.bottomLeft,
            colors: cardPalettesMap["primaryCardBalance"] ?? defaultColors,
            radius: 1.7,
          ),
        ),
        child: const Stack(
          children: [
            Positioned.fill(child: CustomPaint(painter: CardDesignPainter())),
            Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TotalBalance(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [DisplayIncome(), DisplayExpense()],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
