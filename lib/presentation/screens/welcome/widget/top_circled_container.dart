import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';

class TopCircledContainer extends StatelessWidget {
  const TopCircledContainer({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.dyRatio,
    this.cutHeight,
  });

  final double screenHeight;
  final double screenWidth;
  final double dyRatio;
  final double? cutHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight - (cutHeight ?? 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.elliptical(screenWidth / 2, screenHeight * dyRatio),
        ),
        border: horizontalWhiteBorder,
      ),
    );
  }
}
