import 'package:finora/presentation/screens/transaction_search/view_model/flitter_search_transactions_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchTextFeild extends StatelessWidget {
  const SearchTextFeild({super.key});

  @override
  Widget build(BuildContext context) {
    final flitterController = Get.find<FlitterSearchTransactionsController>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(top: 5, left: 20, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
        border: BoxBorder.all(color: Colors.black12),
      ),
      child: Obx(
        () => TextField(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: Colors.grey.shade500,
            hintText: "Search transaction...",
            hintStyle: TextStyle(color: Colors.grey.shade500),
            errorText: flitterController.transactionNameError.value,
            errorMaxLines: 3,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          onChanged: (value) {
            flitterController.validateTransactionName(value);
          },
        ),
      ),
    );
  }
}
