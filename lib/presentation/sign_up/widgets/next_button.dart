import 'package:finora/core/constants.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: ElevatedButton(
        onPressed: () async {},

        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          fixedSize: const Size(250, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text(
          "Next",
          style: TextStyle(color: kSecondColor, fontSize: smallSizeFont),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
