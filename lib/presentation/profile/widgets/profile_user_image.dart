import 'dart:io';
import 'package:finora/core/constants.dart';
import 'package:finora/domain/Extensions/string_operations.dart';
import 'package:finora/domain/entities/user.dart';
import 'package:finora/presentation/sign_up/view_model/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileAndFullNameUserImage extends StatelessWidget {
  const ProfileAndFullNameUserImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 150),
      child: Obx(() {
        final currentUser = AuthController.to.currentUser;
        if (currentUser == null) return const SizedBox();
        return _setTheImageAndTextState(currentUser);
      }),
    );
  }

  Row _setTheImageAndTextState(User currentUser) {
    final Widget profile = setStateUserProfile(currentUser);
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            profile,
            const SizedBox(height: 5),
            Text(
              currentUser.fullName,
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
  }

  static Widget setStateUserProfile(User user) {
    if (user.profileImage == null) {
      return CircleAvatar(
        backgroundColor: Colors.grey[300],
        radius: circleAvatarRadius,
        child: Text(
          user.fullName.initials,
          style: const TextStyle(
            color: kPrimaryColor,
            fontSize: bigSizeFont,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return CircleAvatar(
        radius: circleAvatarRadius,
        backgroundImage: FileImage(File(user.profileImage!.path)),
      );
    }
  }
}
