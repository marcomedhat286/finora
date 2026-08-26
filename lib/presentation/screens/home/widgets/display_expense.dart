import 'package:finora/presentation/screens/home/widgets/current_expense.dart';
import 'package:finora/presentation/screens/home/widgets/expense_text_widget.dart';
import 'package:flutter/material.dart';

class DisplayExpense extends StatelessWidget {
  const DisplayExpense({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [ExpenseTextWidget(), SizedBox(height: 10), CurrentExpense()],
    );
  }
}
