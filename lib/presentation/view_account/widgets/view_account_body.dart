import 'package:finora/domain/entities/account.dart';
import 'package:finora/presentation/screens/display_all_accounts/widgets/gradient_card.dart';
import 'package:finora/presentation/screens/sign_up/widgets/custome_drop_account_types.dart';
import 'package:finora/presentation/screens/sign_up/widgets/custome_text_field.dart';
import 'package:flutter/material.dart';

class ViewAccountBody extends StatelessWidget {
  final Account _account;
  final List<Color> _colors;
  const ViewAccountBody({
    super.key,
    required this._account,
    required this._colors,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          GradientCard(
            type: _account.type.displayName,
            title: _account.name.value,
            accountId: _account.id.value,
            createdAt: _account.createdAt,
            currentBalance: "${_account.currentBalance.value}",
            colors: _colors,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CustomeTextField(
                    dataName: "account name",
                    hinitMessage: "EG. CIB BANK",
                    prefixIcon: Icons.abc,
                    onChanged: (value) {
                      // addAccount.parseAccountName(value);
                    },
                    errorText: null,
                  ),
                  CustomeDropAccountTypes(
                    dataName: "account type",
                    onChanged: (value) {
                      if (value == null) return;
                      // addAccount.parseAccountType(value.code);
                    },
                    // initialValue: addAccount.accountType.value,
                    errorText: null,
                  ),
                  CustomeTextField(
                    dataName: "initial balance",
                    hinitMessage: "EG. 100.0",
                    type: TextInputType.number,
                    prefixIcon: Icons.attach_money,
                    onChanged: (value) {
                      // addAccount.parseAccountInitialBalance(value);
                    },
                    // errorText: addAccount.accountInitialBalanceError.value,
                  ),
                  // AddAccountButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
