import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeadSelectedOption extends StatelessWidget {
  final String SelectedOptionName;
  const HeadSelectedOption({super.key, required this.SelectedOptionName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
      child: Row(
        children: [
          Text(
            SelectedOptionName,
            style: const TextStyle(fontSize: middleSizeFont, fontWeight: .bold),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: kPrimaryColor2,
                fontWeight: .bold,
                fontSize: smallSizeFont * 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
