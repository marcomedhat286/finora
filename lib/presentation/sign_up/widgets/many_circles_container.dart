import 'package:finora/core/constants.dart';
import 'package:finora/presentation/sign_up/widgets/concatnate_circles.dart';
import 'package:flutter/material.dart';

class ManyCirclesContainer extends StatelessWidget {
  const ManyCirclesContainer({super.key, required this.body});

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
        ),
        child: Stack(
          children: [const ConcatnateCircles(), body ?? const SizedBox()],
        ),
      ),
    );
  }
}
