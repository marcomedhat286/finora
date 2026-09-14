import 'package:finora/core/constants.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/presentation/screens/sign_up/widgets/custome_app_bar.dart';
import 'package:finora/presentation/view_account/view_model/update_delete_account_controller.dart';
import 'package:finora/presentation/view_account/widgets/account_option_buttons.dart';
import 'package:finora/presentation/view_account/widgets/update_account_content.dart';
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
    final updateAccountController = Get.find<UpdateDeleteAccountController>();
    updateAccountController.initiateAttributes(_account);
    return Column(
      children: [
        const CustomeAppBar(screenName: "Your Account", color: kPrimaryColor2),
        Text("This account created at ${hourFormat(_account.createdAt)}"),
        UpdateAccountContent(account: _account, colors: _colors),
        const AccountOptionButtons(),
        const SizedBox(height: 20),
      ],
    );
  }

  String hourFormat(DateTime date) => "${date.hour}:${date.minute}";
}
