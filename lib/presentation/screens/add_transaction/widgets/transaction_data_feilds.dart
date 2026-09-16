import 'package:finora/presentation/screens/add_transaction/view_model/add_transaction_controller.dart';
import 'package:finora/presentation/screens/add_transaction/widgets/account_dropdown_selector.dart';
import 'package:finora/presentation/screens/add_transaction/widgets/add_transaction_button.dart';
import 'package:finora/presentation/screens/add_transaction/widgets/custome_transaction_data_container.dart';
import 'package:finora/presentation/screens/add_transaction/widgets/expense_category_drop_down.dart';
import 'package:finora/presentation/screens/add_transaction/widgets/income_category_drop_down.dart';
import 'package:finora/presentation/screens/add_transaction/widgets/select_type_transaction.dart';
import 'package:finora/presentation/screens/sign_up/widgets/custome_date_picker.dart';
import 'package:finora/presentation/screens/sign_up/widgets/custome_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionDataFeilds extends StatelessWidget {
  const TransactionDataFeilds({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddTransactionController>();
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          children: [
            SelectTypeTransaction(),
            CustomeTextField(
              dataName: "title",
              prefixIcon: Icons.abc,
              textEditingController: controller.title,
              errorText: controller.titleError.value,
              paddingSpace: 20,
            ),
            CustomeTextField(
              dataName: "description",
              prefixIcon: Icons.abc,
              textEditingController: controller.description,
              paddingSpace: 20,
            ),
            buildCategoryDropdown(controller: controller, paddingSpace: 20),
            CustomeDatePickerField(
              dataName: "date",
              errorText: controller.createdAtError.value,
              onDateSelected: controller.setCreatedAt,
              initialDate: controller.createdAt.value,
              paddingSpace: 20,
            ),
            const AccountDropdownSelector(),
            CustomeTextField(
              dataName: "Amount",
              prefixIcon: Icons.money,
              textEditingController: controller.amount,
              errorText: controller.amountError.value,
              hinitMessage: "EG. 100",
              type: TextInputType.number,
              paddingSpace: 20,
            ),
            Text(
              controller.otherErrors.value ?? "",
              style: TextStyle(color: Colors.red),
            ),
            const AddTransactionButton(),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryDropdown({
    required AddTransactionController controller,
    required double paddingSpace,
  }) {
    switch (controller.selectedType.value) {
      case TransactionType.income:
        return IncomeCategoryDropDown(paddingSpace: paddingSpace);

      case TransactionType.expense:
        return ExpenseCategoryDropDown(paddingSpace: paddingSpace);
    }
  }
}
