import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddTransactionButton extends StatelessWidget {
  const AddTransactionButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
  });
  final VoidCallback? onPressed;
  final FaIconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: circleBottonSize,
      width: circleBottonSize,
      child: FloatingActionButton(
        heroTag: null,
        onPressed: onPressed,
        shape: CircleBorder(),
        backgroundColor: kPrimaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(icon, color: kSecondColor, size: circleBottonSize / 3),
            const SizedBox(height: 2),
            Text(
              text,
              style: const TextStyle(
                color: kSecondColor,
                fontSize: smallSizeFont / 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
