import 'package:finora/presentation/screens/sign_up/widgets/custome_text_field.dart';
import 'package:finora/presentation/screens/transaction_search/view_model/flitter_search_transactions_controller.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/amount_range_options_ui_list.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/apply_custom_amount_range_button.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/head_selected_option.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/quick_select_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AmountRangeOptionUiBody extends StatelessWidget {
  const AmountRangeOptionUiBody({super.key});

  @override
  Widget build(BuildContext context) {
    final flitterController = Get.find<FlitterSearchTransactionsController>();
    const double space = 20;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: .start,
        children: [
          const HeadSelectedOption(SelectedOptionName: "Amount Range"),
          Obx(
            () => CustomeTextField(
              dataName: "Min Amount",
              prefixIcon: Icons.attach_money_rounded,
              paddingSpace: space,
              hinitMessage: '0',
              type: .number,
              textEditingController: flitterController.minAmountController,
              errorText: flitterController.minAmmountError.value,
              onChanged: (value) {
                flitterController.validateMinAmountRange();
              },
            ),
          ),
          Obx(
            () => CustomeTextField(
              dataName: "Max Amount",
              prefixIcon: Icons.attach_money_rounded,
              paddingSpace: space,
              hinitMessage: 'Any',
              type: .number,
              textEditingController: flitterController.maxAmountController,
              errorText: flitterController.maxAmmountError.value,
              onChanged: (value) => flitterController.validateMaxAmountRange(),
            ),
          ),
          const QuickSelectText(),
          const AmountRangeOptionsUiList(),
          const ApplyCustomAmountRangeButton(),
        ],
      ),
    );
  }
}
