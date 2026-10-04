import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/transaction_search/view_model/flitter_search_transactions_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplyCustomAmountRangeButton extends StatelessWidget {
  const ApplyCustomAmountRangeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final flitterController = Get.find<FlitterSearchTransactionsController>();
    return GestureDetector(
      onTap: () {
        flitterController.setCustomeAmountRange();
      },
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
          decoration: BoxDecoration(
            color: kPrimaryColor2,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            "Apply",
            style: TextStyle(
              color: kSecondColor,
              fontSize: smallSizeFont,
              fontWeight: .w400,
            ),
          ),
        ),
      ),
    );
  }
}
