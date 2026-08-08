import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CurrentIncome extends StatelessWidget {
  const CurrentIncome({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(
          FontAwesomeIcons.dollarSign,
          color: kSecondColorwithAlpha,
          size: 25,
        ),
        const SizedBox(width: 7),
        Text(
          "2000.00",
          style: TextStyle(
            color: kSecondColorwithAlpha,
            fontSize: smallSizeFont + 5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
