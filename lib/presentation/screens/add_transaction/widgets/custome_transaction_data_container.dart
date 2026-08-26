import 'package:finora/core/constants.dart';
import 'package:finora/domain/enum/transaction/expense_category.dart';
import 'package:finora/domain/enum/transaction/income_category.dart';
import 'package:finora/presentation/screens/add_transaction/view/add_transaction_view.dart';
import 'package:finora/presentation/screens/add_transaction/view_model/add_transaction_controller.dart';
import 'package:finora/presentation/screens/add_transaction/widgets/add_transaction_button.dart';
import 'package:finora/presentation/screens/sign_up/widgets/custome_date_picker.dart';
import 'package:finora/presentation/screens/sign_up/widgets/custome_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomeTransactionDataContainer extends StatelessWidget {
  final TransactionType _type;

  const CustomeTransactionDataContainer({super.key, required this._type});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddTransactionController>();
    return Align(
      alignment: AlignmentGeometry.bottomCenter,
      child: Container(
        height: 625,
        margin: const EdgeInsets.symmetric(horizontal: 25),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        decoration: const BoxDecoration(
          color: kSecondColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: blurRadius,
              spreadRadius: 5,
              offset: Offset(0, 15),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                CustomeTextField(
                  dataName: "title",
                  prefixIcon: Icons.abc,
                  textEditingController: controller.title,
                  errorText: controller.titleError.value,
                ),
                CustomeTextField(
                  dataName: "description",
                  prefixIcon: Icons.abc,
                  textEditingController: controller.description,
                ),
                buildCategoryDropdown(controller),
                CustomeDatePickerField(
                  dataName: "date",
                  errorText: controller.createdAtError.value,
                  onDateSelected: controller.setCreatedAt,
                  initialDate: controller.createdAt.value,
                ),
                CustomeTextField(
                  dataName: "Amount",
                  prefixIcon: Icons.money,
                  textEditingController: controller.amount,
                  errorText: controller.amountError.value,
                  hinitMessage: "EG. 100",
                  type: TextInputType.number,
                ),
                Text(
                  controller.otherErrors.value ?? "",
                  style: TextStyle(color: Colors.red),
                ),
                AddTransactionButton(type: _type),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCategoryDropdown(AddTransactionController controller) {
    switch (_type) {
      case TransactionType.Income:
        return _buildIncomeCategoryDropdown(controller);

      case TransactionType.Expense:
        return _buildExpenseCategoryDropdown(controller);
    }
  }

  Widget _buildIncomeCategoryDropdown(AddTransactionController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "income category".toUpperCase(),
            style: CustomeTextField.textStyleDataName,
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<IncomeCategory>(
            initialValue: controller.incomeCategory.value,
            dropdownColor: kPrimaryColor,
            decoration: InputDecoration(
              hintMaxLines: 3,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: FaIcon(FontAwesomeIcons.layerGroup),
              ),
              prefixIconColor: kPrimaryColor,
              errorText: controller.categoryError.value,
              errorMaxLines: 3,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  CustomeTextField.circleBorderRadius,
                ),
                borderSide: const BorderSide(color: Colors.grey),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  CustomeTextField.circleBorderRadius,
                ),
                borderSide: const BorderSide(color: kPrimaryColor),
              ),
            ),
            items: IncomeCategory.values.map((type) {
              return DropdownMenuItem<IncomeCategory>(
                value: type,
                child: Text(
                  type.displayName,
                  style: const TextStyle(
                    color: kSecondColor,
                    fontSize: smallSizeFont,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            }).toList(),
            selectedItemBuilder: (context) {
              return IncomeCategory.values.map((type) {
                return Text(
                  type.displayName,
                  style: const TextStyle(
                    color: kPrimaryColor2,
                    fontSize: smallSizeFont,
                  ),
                );
              }).toList();
            },
            onChanged: (value) {
              controller.incomeCategory.value = value;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseCategoryDropdown(AddTransactionController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "expense category".toUpperCase(),
            style: CustomeTextField.textStyleDataName,
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<ExpenseCategory>(
            initialValue: controller.expenseCategory.value,
            dropdownColor: kPrimaryColor,
            decoration: InputDecoration(
              hintMaxLines: 3,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: FaIcon(FontAwesomeIcons.layerGroup),
              ),
              prefixIconColor: kPrimaryColor,
              errorText: controller.categoryError.value,
              errorMaxLines: 3,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  CustomeTextField.circleBorderRadius,
                ),
                borderSide: const BorderSide(color: Colors.grey),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  CustomeTextField.circleBorderRadius,
                ),
                borderSide: const BorderSide(color: kPrimaryColor),
              ),
            ),
            items: ExpenseCategory.values.map((type) {
              return DropdownMenuItem<ExpenseCategory>(
                value: type,
                child: Text(
                  type.displayName,
                  style: const TextStyle(
                    color: kSecondColor,
                    fontSize: smallSizeFont,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            }).toList(),
            selectedItemBuilder: (context) {
              return ExpenseCategory.values.map((type) {
                return Text(
                  type.displayName,
                  style: const TextStyle(
                    color: kPrimaryColor2,
                    fontSize: smallSizeFont,
                  ),
                );
              }).toList();
            },
            onChanged: (value) {
              controller.expenseCategory.value = value;
            },
          ),
        ],
      ),
    );
  }
}
