import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';

class LogInButton extends StatelessWidget {
  const LogInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have account?",
          style: TextStyle(fontSize: smallSizeFont),
        ),
        TextButton(
          onPressed: () {
            print("log in screen ");
          },
          child: const Text(
            "Log In",
            style: TextStyle(
              fontSize: smallSizeFont,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
