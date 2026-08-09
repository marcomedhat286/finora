import 'dart:io';
import 'package:finora/core/constants.dart';
import 'package:finora/domain/Extensions/string_operations.dart';
import 'package:finora/presentation/sign_up/view_model/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileAndFullNameUserImage extends StatelessWidget {
  const ProfileAndFullNameUserImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 220),
      child: Obx(() {
        final user = AuthController.to.currentUser;
        final Widget profile;
        if (user!.image.path == null) {
          profile = CircleAvatar(
            backgroundColor: Colors.grey[300],
            radius: circleAvatarRadius,
            child: Text(
              user.fullName.initials,
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: bigSizeFont,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else {
          profile = CircleAvatar(
            radius: circleAvatarRadius,
            backgroundImage: FileImage(File(user.image.path!)),
          );
        }
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                profile,
                const SizedBox(height: 10),
                Text(
                  user.fullName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: middleSizeFont,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
