import 'package:finora/core/constants.dart';
import 'package:finora/presentation/home/widgets/display_expense.dart';
import 'package:finora/presentation/home/widgets/display_income.dart';

import 'package:finora/presentation/home/widgets/total_balance.dart';
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
        padding: const EdgeInsets.all(30),
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
        ),
        child: const Column(
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
    );
  }
}
