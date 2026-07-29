import 'package:finora/core/constants.dart';
import 'package:finora/presentation/welcome/widget/circle_container.dart';
import 'package:flutter/material.dart';

class ConcatnateCircles extends StatelessWidget {
  const ConcatnateCircles({super.key, required this.screenWidth});

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -10,
          left: -45,
          child: CircleContainer(
            screenWidth: (screenWidth * 0.75),
            borderColor: kSecondColor.withAlpha(alphaValue),
            borderWidth: 18,
          ),
        ),
        Positioned(
          top: -15,
          left: 80,
          child: CircleContainer(
            screenWidth: (screenWidth * 0.5),
            borderColor: kSecondColor.withAlpha(alphaValue),
            borderWidth: 13,
          ),
        ),
        Positioned(
          top: -25,
          left: 140,
          child: CircleContainer(
            screenWidth: (screenWidth * 0.4),
            borderColor: kSecondColor.withAlpha(alphaValue),
            borderWidth: 10,
          ),
        ),
      ],
    );
  }
}
