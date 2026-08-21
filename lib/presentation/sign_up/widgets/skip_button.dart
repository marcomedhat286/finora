import 'package:finora/core/constants.dart';
import 'package:finora/presentation/sign_up/view_model/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key, required this.controller});

  final SignUpViewModel controller;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        controller.skipAccountStep();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Skip",
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: middleSizeFont,
              fontWeight: FontWeight.bold,
            ),
          ),
          FaIcon(
            FontAwesomeIcons.angleRight,
            color: kPrimaryColor,
            size: middleSizeFont,
          ),
        ],
      ),
    );
  }
}
