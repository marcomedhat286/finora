import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/view_account/view_model/get_list_view_account_transactoin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowAllTransactionsButton extends StatelessWidget {
  const ShowAllTransactionsButton({super.key, required this._accountId});
  final String _accountId;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GetListViewAccountTransactoinController>();
    return TextButton(
      onPressed: () async {
        await controller.updateShowState(_accountId);
      },
      child: Text(
        "all transactions".toUpperCase(),
        style: TextStyle(
          color: kPrimaryColor2,
          fontSize: smallSizeFont,
          fontWeight: .bold,
        ),
      ),
    );
  }
}
