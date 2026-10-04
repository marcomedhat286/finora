import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/home/widgets/not_found_image_icon.dart';
import 'package:finora/presentation/screens/transaction_search/view_model/flitter_search_transactions_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartSearchCertiraWidget extends StatelessWidget {
  const StartSearchCertiraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final flitterController = Get.find<FlitterSearchTransactionsController>();
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: .center,
        children: [
          const NotFoundImageIcon(),
          const SizedBox(height: 10),
          const Text(
            "Start the search criteria with clicking Start button",
            textAlign: .center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: smallSizeFont,
              fontWeight: .w300,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () async {
              await flitterController.search();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: kPrimaryColor, width: 1.5),
              ),
              child: const Text(
                "Start Search",
                style: .new(
                  color: kPrimaryColor2,
                  fontSize: smallSizeFont * 1.2,
                  fontWeight: .bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
