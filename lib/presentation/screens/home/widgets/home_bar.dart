import 'package:finora/core/constants.dart';
import 'package:finora/presentation/controller/auth_accounts_controller.dart';
import 'package:finora/presentation/controller/auth_transactions_controller.dart';

import 'package:finora/presentation/screens/home/widgets/user_full_name.dart';
import 'package:finora/presentation/controller/auth_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeBar extends StatelessWidget {
  const HomeBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Row(
          children: [
            const UserFullName(),
            const Spacer(),
            IconButton(
              onPressed: () {
                logOut();
              },
              icon: const FaIcon(
                FontAwesomeIcons.rightFromBracket,
                color: kSecondColor,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void logOut() {
    AuthUserController.to.logout();
    AuthAccountsController.to.logout();
    AuthTransactionsController.to.logout();
    Get.offAllNamed('/welcome');
  }
}
