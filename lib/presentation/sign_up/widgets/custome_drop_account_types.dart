import 'package:finora/core/constants.dart';
import 'package:finora/domain/enum/account_type.dart';
import 'package:finora/presentation/sign_up/view_model/sign_up_view_model.dart';
import 'package:finora/presentation/sign_up/widgets/custome_text_field.dart';
import 'package:flutter/material.dart';

class CustomrDropAccountTypes extends StatelessWidget {
  const CustomrDropAccountTypes({
    super.key,
    required this.dataName,
    required this.errorText,
    required this.controller,
  });
  final String dataName;
  final String? errorText;
  final SignUpViewModel controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dataName.toUpperCase(),
            style: CustomeTextField.textStyleDataName,
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<AccountType>(
            initialValue: controller.accountType.value,
            dropdownColor: kPrimaryColor,
            decoration: InputDecoration(
              hintMaxLines: 3,
              prefixIcon: const Icon(Icons.type_specimen),
              prefixIconColor: kPrimaryColor,
              errorText: errorText,
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
            items: AccountType.values.map((type) {
              return DropdownMenuItem<AccountType>(
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
              return AccountType.values.map((type) {
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
              controller.accountType.value = value;
            },
          ),
        ],
      ),
    );
  }
}
