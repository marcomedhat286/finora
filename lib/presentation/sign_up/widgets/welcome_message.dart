import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      textAlign: TextAlign.center,
      "Welcome to $appName 👋",
      style: TextStyle(
        fontSize: middleSizeFont,
        color: kSecondColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
