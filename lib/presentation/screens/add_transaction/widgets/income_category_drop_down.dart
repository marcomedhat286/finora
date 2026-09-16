import 'package:finora/core/constants.dart';
import 'package:finora/domain/enum/transaction/income_category.dart';
import 'package:finora/presentation/screens/add_transaction/view_model/add_transaction_controller.dart';
import 'package:finora/presentation/screens/sign_up/widgets/custome_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class IncomeCategoryDropDown extends StatelessWidget {
  const IncomeCategoryDropDown({super.key, this._paddingSpace = 0});
  final double _paddingSpace;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddTransactionController>();
    return Padding(
      padding: EdgeInsets.only(
        bottom: 15,
        left: _paddingSpace,
        right: _paddingSpace,
      ),
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
}
