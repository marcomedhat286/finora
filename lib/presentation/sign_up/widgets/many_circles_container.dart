import 'package:finora/core/constants.dart';
import 'package:finora/presentation/sign_up/widgets/concatnate_circles.dart';
import 'package:finora/presentation/sign_up/widgets/custome_app_bar.dart';
import 'package:flutter/material.dart';

class ManyCirclesContainer extends StatelessWidget {
  const ManyCirclesContainer({
    super.key,
    required this.screenWidth,
    required this.screenheight,
  });

  final double screenWidth;
  final double screenheight;

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
            const CustomeAppBar(),
          ],
        ),
      ),
    );
  }
}
