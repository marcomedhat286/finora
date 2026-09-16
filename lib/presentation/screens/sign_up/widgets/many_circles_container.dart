import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/sign_up/widgets/concatnate_circles.dart';
import 'package:flutter/material.dart';

class ManyCirclesContainer extends StatelessWidget {
  const ManyCirclesContainer({super.key, this.body});

  final Widget? body;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Align(
      alignment: AlignmentGeometry.topCenter,
      child: Container(
        width: screenWidth,
        height: screenHeight - 500,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(screenWidth / 2, screenHeight * .05),
          ),
          gradient: LinearGradient(
            begin: .topRight,
            end: .bottomLeft,
            colors: cardPalettesMap['primaryCardBalance'] ?? defaultColors,
            stops: [0.2, 0.4, 0.8],
          ),
        ),
        child: Stack(
          children: [const ConcatnateCircles(), body ?? const SizedBox()],
        ),
      ),
    );
  }
}
