import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';

class SmallTextMessage extends StatelessWidget {
  const SmallTextMessage({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        message,
        overflow: TextOverflow.fade,
        style: const TextStyle(fontSize: smallSizeFont, color: kSecondColor),
        textAlign: TextAlign.center,
      ),
    );
  }
}
