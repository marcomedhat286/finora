import 'package:finora/presentation/home/widgets/current_expense.dart';
import 'package:finora/presentation/home/widgets/expense_text_widget.dart';
import 'package:flutter/material.dart';

class DisplayExpense extends StatelessWidget {
  const DisplayExpense({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ExpenseTextWidget(), SizedBox(height: 10), CurrentExpense()],
    );
  }
}
