import 'package:finora/core/constants.dart';
import 'package:finora/presentation/home/view_model.dart/bottom_app_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomeFAB extends StatelessWidget {
  final VoidCallback onPressed;
  const CustomeFAB({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BottomAppBarController>();
    return Positioned(
      left: 143,
      bottom: 85,
      child: SizedBox(
        height: circleBottonSize,
        width: circleBottonSize,
        child: FloatingActionButton(
          heroTag: null,
          onPressed: onPressed,
          shape: CircleBorder(),
          backgroundColor: kPrimaryColor,
          child: Obx(
            () => FaIcon(
              controller.fabIcon,
              color: kSecondColor,
              size: circleBottonSize / 3,
            ),
          ),
        ),
      ),
    );
  }
}
