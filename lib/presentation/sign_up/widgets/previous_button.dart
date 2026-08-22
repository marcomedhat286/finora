import 'package:finora/core/constants.dart';
import 'package:finora/presentation/sign_up/view_model/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreviousButton extends StatelessWidget {
  const PreviousButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignUpViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        onPressed: () {
          controller.perviousStep();
        },

        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          fixedSize: const Size(100, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text(
          "Back",
          style: TextStyle(color: kSecondColor, fontSize: smallSizeFont),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
