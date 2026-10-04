import 'package:finora/core/constants.dart';
import 'package:finora/domain/enum/transaction/date_range_options.dart';
import 'package:finora/presentation/screens/transaction_search/view_model/flitter_search_transactions_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateRangeOptionsViewCardsList extends StatelessWidget {
  const DateRangeOptionsViewCardsList({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 370,
      child: ListView.builder(
        itemCount: DateRangeOptions.values.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final dateOption = DateRangeOptions.values[index];
          return DateRangeOptionViewCard(dateOption: dateOption);
        },
      ),
    );
  }
}

class DateRangeOptionViewCard extends StatelessWidget {
  const DateRangeOptionViewCard({super.key, required this.dateOption});

  final DateRangeOptions dateOption;

  @override
  Widget build(BuildContext context) {
    final flitterController = Get.find<FlitterSearchTransactionsController>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          Obx(() {
            final isSelected = flitterController.isEqualToDateRangeOption(
              dateOption,
            );
            return Checkbox(
              value: isSelected,
              onChanged: (value) {
                if (value == null) return;
                if (value == true) {
                  flitterController.selectDateRangeOption(dateOption);
                }
              },
              shape: const CircleBorder(),
              activeColor: kPrimaryColor2,
            );
          }),
          Text(
            dateOption.displayName,
            style: const TextStyle(fontSize: smallSizeFont, fontWeight: .w700),
          ),
        ],
      ),
    );
  }
}
