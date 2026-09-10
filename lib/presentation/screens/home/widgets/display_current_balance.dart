import 'package:finora/core/constants.dart';
import 'package:finora/presentation/controller/auth_accounts_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DisplayCurrentBalance extends StatelessWidget {
  const DisplayCurrentBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const FaIcon(
          FontAwesomeIcons.dollarSign,
          color: kSecondColor,
          size: 35,
        ),
        const SizedBox(width: 7),
        Obx(() {
          final currentBalance =
              AuthAccountsController.to.totalCurrentBalanceAccounts;
          return Text(
            currentBalance.toString(),
            style: const TextStyle(
              color: kSecondColor,
              fontSize: smallSizeFont + 15,
              fontWeight: FontWeight.bold,
            ),
          );
        }),
      ],
    );
  }
}
