import 'dart:io';
import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/edit_profile/view_model/update_user_profile_view_model.dart';
import 'package:finora/presentation/screens/profile/widgets/profile_user_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileImage extends StatelessWidget {
  const EditProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UpdateUserInfoViewModel>();
    return Stack(
      children: [
        Obx(() {
          final imagePath = controller.selectedImagePath.value;
          if (imagePath != null &&
              !imagePath.startsWith('http') &&
              File(imagePath).existsSync()) {
            return CircleAvatar(
              radius: circleAvatarRadius,
              backgroundImage: FileImage(File(imagePath)),
            );
          }
          return ProfileAndFullNameUserImage.setStateUserProfile(
            controller.currentUser,
            isRemoved: controller.isImageChanged.value,
          );
        }),

        Container(
          margin: const EdgeInsets.only(top: circleAvatarRadius * 1.5),
          width: (circleAvatarRadius * 2) + 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => controller.removeProfileImage(),
                icon: const CircleAvatar(
                  backgroundColor: kPrimaryColor,
                  child: Icon(Icons.cancel, color: kSecondColor),
                ),
              ),
              IconButton(
                onPressed: () => controller.pickNewProfileImage(),
                icon: const CircleAvatar(
                  backgroundColor: kPrimaryColor,
                  child: Icon(Icons.edit, color: kSecondColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
