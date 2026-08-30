import 'package:finora/presentation/screens/add_account/view_model/add_account_controller.dart';
import 'package:finora/presentation/screens/add_account/widgets/add_account_button.dart';
import 'package:finora/presentation/screens/add_account/widgets/check_default_account.dart';
import 'package:finora/presentation/screens/sign_up/widgets/custome_drop_account_types.dart';
import 'package:finora/presentation/screens/sign_up/widgets/custome_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountData extends StatelessWidget {
  const AccountData({super.key, required this.addAccount});

  final AddAccountController addAccount;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(
          () => Column(
            children: [
              CustomeTextField(
                dataName: "account name",
                hinitMessage: "EG. CIB BANK",
                prefixIcon: Icons.abc,
                onChanged: (value) {
                  addAccount.parseAccountName(value);
                },
                errorText: addAccount.accountNameError.value,
              ),
              CustomeDropAccountTypes(
                dataName: "account type",
                onChanged: (value) {
                  if (value == null) return;
                  addAccount.parseAccountType(value.code);
                },
                initialValue: addAccount.accountType.value,
                errorText: addAccount.accountTypeError.value,
              ),
              CustomeTextField(
                dataName: "initial balance",
                hinitMessage: "EG. 100.0",
                type: TextInputType.number,
                prefixIcon: Icons.attach_money,
                onChanged: (value) {
                  addAccount.parseAccountInitialBalance(value);
                },
                errorText: addAccount.accountInitialBalanceError.value,
              ),
              CheckDefaultAccount(
                defaultValue: addAccount.isDefault.value,
                onChanged: (value) {
                  if (value == null) return;
                  addAccount.isDefault.value = value;
                },
              ),
              AddAccountButton(),
            ],
          ),
        ),
      ),
    );
  }
}
