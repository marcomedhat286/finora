import 'package:finora/core/constants.dart';
import 'package:finora/presentation/controller/auth_accounts_controller.dart';
import 'package:finora/presentation/screens/sign_up/widgets/custome_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAccountTopText extends StatelessWidget {
  const AddAccountTopText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomeAppBar(screenName: "Accounts"),
        SizedBox(height: 10),
        Obx(
          () => Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Manage all your accounts in one place."
              " Create new accounts effortlessly and keep your finances organized, clear, and under control. "
              "You have ${AuthAccountsController.to.userAccounts.length} accounts.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kSecondColor,
                fontSize: smallSizeFont,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
