import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomeAppBar extends StatelessWidget {
  const CustomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 35, 16, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const FaIcon(FontAwesomeIcons.angleLeft, color: kSecondColor),
          ),
          const Spacer(),
          const Text(
            "Sign Up",
            style: TextStyle(
              color: kSecondColor,
              fontSize: middleSizeFont,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
