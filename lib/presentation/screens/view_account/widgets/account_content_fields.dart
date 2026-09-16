import 'package:finora/presentation/screens/add_account/widgets/check_default_account.dart';
import 'package:finora/presentation/screens/sign_up/widgets/custome_drop_account_types.dart';
import 'package:finora/presentation/screens/sign_up/widgets/custome_text_field.dart';
import 'package:finora/presentation/screens/view_account/view_model/update_delete_account_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountContentFields extends StatelessWidget {
  const AccountContentFields({super.key});

  @override
  Widget build(BuildContext context) {
    final updateAccountController = Get.find<UpdateDeleteAccountController>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
      child: Obx(
        () => Column(
          children: [
            CustomeTextField(
              dataName: "account name",
              hinitMessage:
                  updateAccountController.oldAccount.value?.name.value,
              prefixIcon: Icons.abc,
              onChanged: (value) {
                updateAccountController.parseAccountName(value);
              },
              errorText: updateAccountController.accountNameError.value,
            ),
            CustomeDropAccountTypes(
              dataName: "account type",
              onChanged: (value) {
                if (value == null) return;
                updateAccountController.parseAccountType(value.code);
              },
              initialValue: updateAccountController.oldAccount.value?.type,
              errorText: updateAccountController.accountTypeError.value,
            ),
            getAccountInitialBalanceState(updateAccountController),
            CheckDefaultAccount(
              defaultValue: updateAccountController.isDefault.value,
              onChanged: (value) {
                if (value == null) return;
                updateAccountController.isDefault.value = value;
              },
            ),
          ],
        ),
      ),
    );
  }

  StatelessWidget getAccountInitialBalanceState(
    UpdateDeleteAccountController updateAccountController,
  ) {
    return (updateAccountController.oldAccount.value?.hasTransactions != null &&
            !updateAccountController.oldAccount.value!.hasTransactions)
        ? CustomeTextField(
            dataName: "initial balance",
            hinitMessage:
                "EG.${updateAccountController.oldAccount.value?.currentBalance.value}",
            type: TextInputType.number,
            prefixIcon: Icons.attach_money,
            onChanged: (value) {
              updateAccountController.parseAccountInitialBalance(value);
            },
            errorText: updateAccountController.accountInitialBalanceError.value,
          )
        : const Text(
            "This account has transaction so u can't change the initial Balance.",
          );
  }
}
