import 'package:finora/core/constants.dart';
import 'package:finora/presentation/home/widgets/display_current_balance.dart';
import 'package:flutter/material.dart';

class TotalBalance extends StatelessWidget {
  const TotalBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Total Balance",
          style: TextStyle(
            color: kSecondColor,
            fontSize: smallSizeFont + 5,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        DisplayCurrentBalance(),
      ],
    );
  }
}
