import 'package:finora/core/constants.dart';
import 'package:finora/presentation/controller/auth_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CurrentIncome extends StatelessWidget {
  const CurrentIncome({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AuthUserController.to;
    return Row(
      children: [
        FaIcon(
          FontAwesomeIcons.dollarSign,
          color: kSecondColorwithAlpha,
          size: 25,
        ),
        const SizedBox(width: 7),
        Obx(
          () => Text(
            "${controller.totalIncomes} EG.",
            style: TextStyle(
              color: kSecondColorwithAlpha,
              fontSize: smallSizeFont + 5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
