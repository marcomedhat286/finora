import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/add_transaction/widgets/drop_accounts_button.dart';
import 'package:flutter/material.dart';

class ChooseAccountHide extends StatelessWidget {
  const ChooseAccountHide({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(
            'Choose Account',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor2,
            ),
          ),
          DropAccountsButton(),
        ],
      ),
    );
  }
}
