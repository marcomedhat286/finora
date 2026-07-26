import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';

class AppNameText extends StatelessWidget {
  const AppNameText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      appName,
      style: TextStyle(
        fontSize: bigSizeFont,
        color: lightFontColor,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}
