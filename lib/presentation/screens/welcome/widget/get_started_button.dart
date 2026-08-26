import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        navigateToSignUp();
      },
      style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 100),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: kPrimaryColor,
              blurRadius: blurRadius,
              spreadRadius: 8,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: const Text(
          "Get Started",
          style: TextStyle(color: kSecondColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void navigateToSignUp() {
    Get.toNamed('/signup');
  }
}
