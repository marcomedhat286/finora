import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print("welcom to fionra");
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
          style: TextStyle(color: lightFontColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
