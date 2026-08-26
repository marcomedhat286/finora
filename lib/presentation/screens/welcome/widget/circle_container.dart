import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';

class CircleContainer extends StatelessWidget {
  const CircleContainer({
    super.key,
    required this.screenWidth,
    this.borderColor = kSecondColor,
    this.borderWidth = 2,
  });

  final double screenWidth;
  final Color borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth - 50,
      height: screenWidth - 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }
}
