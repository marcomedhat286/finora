import 'package:finora/core/constants.dart';
import 'package:finora/presentation/sign_up/view_model/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignUpViewModel>();
    return TextButton(
      onPressed: () {
        controller.skipAccountStep();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Skip this for now",
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: smallSizeFont - 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 3),
          FaIcon(
            FontAwesomeIcons.angleRight,
            color: kPrimaryColor,
            size: smallSizeFont - 4,
          ),
        ],
      ),
    );
  }
}
