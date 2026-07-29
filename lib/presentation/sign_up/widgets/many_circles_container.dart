import 'package:finora/core/constants.dart';
import 'package:finora/presentation/sign_up/widgets/concatnate_circles.dart';
import 'package:flutter/material.dart';

class ManyCirclesContainer extends StatelessWidget {
  const ManyCirclesContainer({
    super.key,
    required this.screenWidth,
    required this.screenheight,
    required this.body,
  });

  final double screenWidth;
  final double screenheight;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.topCenter,
      child: Container(
        width: screenWidth,
        height: screenheight - 500,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(screenWidth / 2, screenheight * .05),
          ),
        ),
        child: Stack(
          children: [
            ConcatnateCircles(screenWidth: screenWidth),
            body,
          ],
        ),
      ),
    );
  }
}
