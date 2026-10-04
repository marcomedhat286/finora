import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';

class ActionTransactionButton extends StatelessWidget {
  const ActionTransactionButton({super.key, required this.actionName});
  final String actionName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(actionName);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        decoration: BoxDecoration(
          color: cardPalettesMap['primaryCardBalance']?[1],
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: kPrimaryColor3,
              blurRadius: blurRadius,
              spreadRadius: 3,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Text(
          actionName.toUpperCase(),
          style: const TextStyle(color: kPrimaryColor2),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
