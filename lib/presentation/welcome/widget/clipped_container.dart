import 'package:finora/core/constants.dart';
import 'package:finora/presentation/welcome/widget/clipper_line.dart';
import 'package:finora/presentation/welcome/widget/get_started_button.dart';
import 'package:finora/presentation/welcome/widget/login_button.dart';
import 'package:finora/presentation/welcome/widget/text_message.dart';
import 'package:flutter/material.dart';

class ClippedContainer extends StatelessWidget {
  const ClippedContainer({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.bottomCenter,
      child: ClipPath(
        clipper: const MyClipper(),
        child: Container(
          color: kSecondColor,
          height: screenHeight - 450,
          width: screenWidth,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextMessage(),
              GetStartedButton(),
              SizedBox(height: 5),
              LogInButton(),
            ],
          ),
        ),
      ),
    );
  }
}
