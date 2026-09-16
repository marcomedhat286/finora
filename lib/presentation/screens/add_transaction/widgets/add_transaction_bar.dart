import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AddTransactionBar extends StatelessWidget {
  const AddTransactionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70),
      child: Column(
        children: [
          Row(
            spacing: 70,
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const FaIcon(
                  FontAwesomeIcons.angleLeft,
                  color: kSecondColor,
                ),
              ),
              Text(
                "Add Transaction",
                style: const TextStyle(
                  color: kSecondColor,
                  fontSize: middleSizeFont,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            "Fill all information and click to add to make the transaction.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kSecondColor,
              fontSize: smallSizeFont,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
