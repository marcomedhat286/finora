import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IncomeTextWidget extends StatelessWidget {
  const IncomeTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FaIcon(
          FontAwesomeIcons.arrowDown,
          color: kSecondColorwithAlpha,
          size: 20,
        ),
        const SizedBox(width: 10),
        Text(
          "Income",
          style: TextStyle(
            color: kSecondColorwithAlpha,
            fontSize: smallSizeFont + 3,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
