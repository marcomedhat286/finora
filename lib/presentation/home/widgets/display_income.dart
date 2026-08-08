import 'package:finora/presentation/home/widgets/current_income.dart';
import 'package:finora/presentation/home/widgets/income_text_widget.dart';
import 'package:flutter/material.dart';

class DisplayIncome extends StatelessWidget {
  const DisplayIncome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [IncomeTextWidget(), SizedBox(height: 10), CurrentIncome()],
    );
  }
}
