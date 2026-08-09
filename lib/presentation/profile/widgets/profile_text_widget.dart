import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';

class ProfileTextWidget extends StatelessWidget {
  const ProfileTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Profile",
            style: TextStyle(
              color: kSecondColor,
              fontSize: middleSizeFont,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
