import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/transaction_search/view_model/flitter_search_transactions_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplyCustomDateRangeButton extends StatelessWidget {
  const ApplyCustomDateRangeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final flitterController = Get.find<FlitterSearchTransactionsController>();
    return GestureDetector(
      onTap: () {
        flitterController.setCustomDateRange();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
        decoration: BoxDecoration(
          color: kPrimaryColor2,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          "Apply",
          style: const TextStyle(
            color: kSecondColor,
            fontSize: smallSizeFont,
            fontWeight: .bold,
          ),
        ),
      ),
    );
  }
}
