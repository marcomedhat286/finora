import 'package:finora/core/constants.dart';
import 'package:finora/presentation/sign_up/view_model/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class UserFullName extends StatelessWidget {
  const UserFullName({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${getGreeting()},",
          style: const TextStyle(
            color: kSecondColor,
            fontSize: smallSizeFont,
            fontWeight: FontWeight.bold,
          ),
        ),
        Obx(() {
          final String? fullName = AuthController.to.currentUser?.fullName;
          return SizedBox(
            width: 200,
            child: Text(
              fullName ?? "No User",
              style: const TextStyle(
                color: kSecondColor,
                fontSize: middleSizeFont,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.clip,
            ),
          );
        }),
      ],
    );
  }

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else if (hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }
}
