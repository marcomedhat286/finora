import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';

class CircleContainer extends StatelessWidget {
  const CircleContainer({super.key, required this.screenWidth});

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth - 50,
      height: screenWidth - 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: lightFontColor, width: 2),
      ),
    );
  }
}
