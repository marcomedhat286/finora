import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';

class QuickSelectText extends StatelessWidget {
  const QuickSelectText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        "Quick Select",
        style: TextStyle(fontSize: smallSizeFont * 1.4, fontWeight: .bold),
      ),
    );
  }
}
