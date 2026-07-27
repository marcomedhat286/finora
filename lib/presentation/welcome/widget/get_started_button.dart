import 'package:finora/core/constants.dart';
import 'package:finora/presentation/sign_up/view/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Get.to(
          const SignUp(),
          transition: Transition.fade,
          duration: const Duration(seconds: kTranstionDuration),
        );
      },

      style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 100),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: kPrimaryColor,
              blurRadius: 30,
              spreadRadius: 13,
              offset: Offset(0, 10),
            ),
          ],
        ),
        // width: screenWidth - 100,
        child: const Text(
          "Get Started",
          style: TextStyle(color: kSecondColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
