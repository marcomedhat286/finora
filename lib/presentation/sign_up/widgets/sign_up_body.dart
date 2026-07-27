import 'package:finora/core/constants.dart';
import 'package:finora/presentation/welcome/widget/circle_container.dart';
import 'package:flutter/material.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenheight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Align(
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
                Positioned(
                  top: -10,
                  left: -45,
                  child: CircleContainer(
                    screenWidth: (screenWidth * 0.75),
                    borderColor: kSecondColor.withOpacity(opicatyValue),
                    borderWidth: 18,
                  ),
                ),
                Positioned(
                  top: -15,
                  left: 80,
                  child: CircleContainer(
                    screenWidth: (screenWidth * 0.5),
                    borderColor: kSecondColor.withOpacity(opicatyValue),
                    borderWidth: 13,
                  ),
                ),
                Positioned(
                  top: -25,
                  left: 140,
                  child: CircleContainer(
                    screenWidth: (screenWidth * 0.4),
                    borderColor: kSecondColor.withOpacity(opicatyValue),
                    borderWidth: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: AlignmentGeometry.bottomCenter,
          child: Container(
            height: 625,
            margin: EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              color: kSecondColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 40,
                  spreadRadius: 5,
                  offset: Offset(0, 5),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
