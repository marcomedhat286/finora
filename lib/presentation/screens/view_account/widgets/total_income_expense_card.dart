import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/view_account/view_model/get_list_view_account_transactoin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TotalIncomeExpenseCard extends StatelessWidget {
  const TotalIncomeExpenseCard({super.key});

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(color: kSecondColor, fontWeight: .bold);
    final contoller = Get.find<GetListViewAccountTransactoinController>();
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kPrimaryColor2,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Row(
            children: [
              const Spacer(),
              Text("Income:".toUpperCase(), style: style),
              const Spacer(),
              Text("${contoller.totalIncome}", style: style),
              const Spacer(flex: 5),
              Text("Expense:".toUpperCase(), style: style),
              const Spacer(),
              Text("${contoller.totalExpense}", style: style),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              const SizedBox(width: 10),
              Text("Transaction Numer:".toUpperCase(), style: style),
              const SizedBox(width: 5),
              Text("${contoller.allAccountTransaction.value}", style: style),
            ],
          ),
        ],
      ),
    );
  }
}
