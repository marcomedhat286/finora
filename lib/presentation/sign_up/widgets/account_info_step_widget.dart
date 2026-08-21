import 'package:finora/presentation/sign_up/view_model/sign_up_view_model.dart';
import 'package:finora/presentation/sign_up/widgets/custome_text_field.dart';
import 'package:finora/presentation/sign_up/widgets/custome_drop_account_types.dart';
import 'package:finora/presentation/sign_up/widgets/next_button.dart';
import 'package:finora/presentation/sign_up/widgets/skip_button.dart';
import 'package:flutter/material.dart';
import 'package:finora/presentation/sign_up/widgets/previous_button.dart';
import 'package:get/get.dart';

class AccountInfoStepWidget extends StatelessWidget {
  const AccountInfoStepWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignUpViewModel>();
    return Obx(
      () => Column(
        children: [
          Text(
            "Enter Inforamtion about new account, or skip and we will generate new default account for u.",
            style: CustomeTextField.textStyleDataName,
          ),
          const SizedBox(height: 20),
          CustomeTextField(
            dataName: "Account Name",
            hinitMessage: "EG. CIB BANK",
            prefixIcon: Icons.abc_outlined,
            textEditingController: controller.accountNameController,
            errorText: controller.accountNameError.value,
          ),
          CustomrDropAccountTypes(
            dataName: "account type",
            errorText: controller.accountTypeError.value,
            controller: controller,
          ),
          CustomeTextField(
            dataName: "Initial Balance",
            hinitMessage: "EG. 100.0",
            prefixIcon: Icons.money,
            textEditingController: controller.initialBalanceController,
            errorText: controller.initialBalanceError.value,
          ),
          SkipButton(controller: controller),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [const PreviousButton(), const NextButton()],
          ),
        ],
      ),
    );
  }
}
