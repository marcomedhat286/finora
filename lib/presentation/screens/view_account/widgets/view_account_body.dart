import 'package:finora/core/constants.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/presentation/screens/sign_up/widgets/custome_app_bar.dart';
import 'package:finora/presentation/screens/view_account/view_model/update_delete_account_controller.dart';
import 'package:finora/presentation/screens/view_account/widgets/account_option_buttons.dart';
import 'package:finora/presentation/screens/view_account/widgets/more_information_account.dart';
import 'package:finora/presentation/screens/view_account/widgets/show_all_transactions_button.dart';
import 'package:finora/presentation/screens/view_account/widgets/update_account_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    Get.find<UpdateDeleteAccountController>().initiateAttributes(_account);
    return SingleChildScrollView(
      child: Column(
        children: [
          const CustomeAppBar(
            screenName: "Your Account",
            color: kPrimaryColor2,
          ),
          Text("This account created at ${hourFormat(_account.createdAt)}"),
          const SizedBox(height: 5),
          const SizedBox(height: 5),
          UpdateAccountContent(account: _account, colors: _colors),
          const SizedBox(height: 5),
          const AccountOptionButtons(),
          ShowAllTransactionsButton(accountId: _account.id.value),
          const MoreInformationAccount(),
        ],
      ),
    );
  }

  String hourFormat(DateTime date) =>
      "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
}
