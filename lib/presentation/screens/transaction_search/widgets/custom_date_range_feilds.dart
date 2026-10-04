import 'package:finora/presentation/screens/sign_up/widgets/custome_date_picker.dart';
import 'package:finora/presentation/screens/transaction_search/view_model/flitter_search_transactions_controller.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/apply_custom_date_range_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDateRangeFeilds extends StatelessWidget {
  const CustomDateRangeFeilds({super.key});

  @override
  Widget build(BuildContext context) {
    final flitterController = Get.find<FlitterSearchTransactionsController>();
    return Obx(() {
      if (flitterController.isEqualToCustomDateRangeOption) {
        return Column(
          children: [
            CustomeDatePickerField(
              dataName: "From",
              initialDate: flitterController.from,
              suffixCancelIcon: Icons.cancel_rounded,
              onTapIcon: flitterController.removeFromDateTime,
              onDateSelected: (date) {
                if (date == null) return;
                flitterController.validateFromDateTime(date);
              },
              errorText: flitterController.dateTimeFromError.value,
              paddingSpace: 20,
            ),
            CustomeDatePickerField(
              dataName: "To",
              initialDate: flitterController.to,
              onDateSelected: (date) {
                if (date == null) return;
                flitterController.validateToDateTime(date);
              },
              errorText: flitterController.dateTimeToError.value,
              paddingSpace: 20,
            ),
            const ApplyCustomDateRangeButton(),
            const SizedBox(height: 50),
          ],
        );
      } else {
        return SizedBox.shrink();
      }
    });
  }
}
