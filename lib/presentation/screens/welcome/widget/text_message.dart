import 'package:finora/core/constants.dart';
import 'package:flutter/widgets.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Spend Smarter\n\t\t\t\tSave More",
      style: TextStyle(
        color: kPrimaryColor,
        fontSize: middleSizeFont,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
