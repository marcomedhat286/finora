import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/add_account/view_model/add_account_controller.dart';
import 'package:finora/presentation/screens/add_account/widgets/account_data.dart';
import 'package:finora/presentation/screens/display_all_accounts/widgets/gradient_card.dart';
import 'package:finora/presentation/screens/add_account/widgets/add_account_top_text.dart';
import 'package:finora/presentation/screens/sign_up/widgets/many_circles_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAccountBody extends StatelessWidget {
  const AddAccountBody({super.key});

  @override
  Widget build(BuildContext context) {
    final previewLive = Get.find<AddAccountController>();

    return Stack(
      children: [
        const ManyCirclesContainer(body: AddAccountTopText()),
        Padding(
          padding: const EdgeInsets.only(top: 180),
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              color: kSecondColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Obx(
                    () => GradientCard(
                      title: previewLive.accountName.value ?? "Name",
                      type: previewLive.accountType.value.displayName,
                      currentBalance:
                          previewLive.accountInitialBalance.value ?? "0.0",
                      createdAt: previewLive.accountCreatedAt.value,
                      accountId: "************",
                      colors:
                          cardPalettesMap["addAccountPreviewCard"] ??
                          defaultColors,
                    ),
                  ),
                  AccountData(addAccount: previewLive),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
