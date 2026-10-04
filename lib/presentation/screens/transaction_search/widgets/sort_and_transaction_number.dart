import 'package:finora/core/constants.dart';
import 'package:finora/domain/enum/transaction/transaction_sort_option.dart';
import 'package:finora/presentation/screens/transaction_search/view_model/flitter_search_transactions_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SortAndTransactionNumber extends StatelessWidget {
  const SortAndTransactionNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final flitterController = Get.find<FlitterSearchTransactionsController>();
    const style = TextStyle(color: kSecondColor, fontWeight: .w400);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: .center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Text(
                  "Sort by:",
                  style: TextStyle(fontSize: smallSizeFont, fontWeight: .w300),
                ),
                const SizedBox(width: 5),
                PopupMenuButton<TransactionSortOption>(
                  color: kPrimaryColor2,
                  onSelected: (value) {
                    flitterController.setTransactionSortOption(value);
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: TransactionSortOption.newest,
                      child: Text(
                        TransactionSortOption.newest.displayName,
                        style: style,
                      ),
                    ),
                    PopupMenuItem(
                      value: TransactionSortOption.oldest,
                      child: Text(
                        TransactionSortOption.oldest.displayName,
                        style: style,
                      ),
                    ),
                  ],
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(
                        () => Text(
                          flitterController
                              .transactionSortOption
                              .value
                              .displayName,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: smallSizeFont,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      const FaIcon(
                        FontAwesomeIcons.angleDown,
                        size: smallSizeFont,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Obx(
            () => Text(
              "${flitterController.result.length} transactions",
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: .w500,
                fontSize: smallSizeFont,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
