import 'package:finora/core/constants.dart';
import 'package:finora/domain/enum/transaction/amount_range_option.dart';
import 'package:finora/presentation/screens/transaction_search/view_model/flitter_search_transactions_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AmountRangeCardOption extends StatelessWidget {
  const AmountRangeCardOption({super.key, required this._option});
  final AmountRangeOptions _option;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FlitterSearchTransactionsController>();
    return GestureDetector(
      onTap: () async {
        await controller.setQuickAmountRange(_option);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Text(
          _option.displayRange,
          style: const TextStyle(fontSize: smallSizeFont, fontWeight: .w400),
        ),
      ),
    );
  }
}
