import 'package:finora/domain/entities/account.dart';
import 'package:finora/presentation/screens/display_all_accounts/widgets/gradient_card.dart';
import 'package:finora/presentation/screens/view_account/view_model/update_delete_account_controller.dart';
import 'package:finora/presentation/screens/view_account/widgets/account_content_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateAccountContent extends StatelessWidget {
  const UpdateAccountContent({
    super.key,

    required this._account,
    required this._colors,
  });

  final Account _account;
  final List<Color> _colors;

  @override
  Widget build(BuildContext context) {
    final updateAccountController = Get.find<UpdateDeleteAccountController>();
    return Flexible(
      child: SingleChildScrollView(
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GradientCard(
                type:
                    updateAccountController.accountType.value?.displayName ??
                    "Type",
                title: updateAccountController.accountName.value ?? "Card Name",
                accountId: _account.id.value,
                createdAt: _account.createdAt,
                currentBalance:
                    "${updateAccountController.accountInitialBalance.value}",
                colors: _colors,
              ),
              const AccountContentFields(),
            ],
          ),
        ),
      ),
    );
  }
}
