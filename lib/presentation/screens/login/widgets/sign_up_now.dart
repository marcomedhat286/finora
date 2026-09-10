import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpNow extends StatelessWidget {
  const SignUpNow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "If u don't have account,",
          style: TextStyle(
            color: kPrimaryColor2,
            fontSize: smallSizeFont,
            fontWeight: FontWeight.w400,
          ),
        ),
        TextButton(
          onPressed: () {
            Get.toNamed("/signup");
          },
          child: Text(
            "Sign Up Now",
            style: TextStyle(
              color: kPrimaryColor2,
              fontSize: smallSizeFont,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
