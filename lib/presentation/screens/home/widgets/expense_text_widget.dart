import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExpenseTextWidget extends StatelessWidget {
  const ExpenseTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FaIcon(
          FontAwesomeIcons.arrowUp,
          color: kSecondColorwithAlpha,
          size: 20,
        ),
        const SizedBox(width: 10),
        Text(
          "Expense",
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
