import 'package:finora/core/constants.dart';
import 'package:finora/domain/entities/user.dart';
import 'package:finora/presentation/edit_profile/view_model/update_user_profile_view_model.dart';
import 'package:finora/presentation/profile/widgets/profile_user_image.dart';
import 'package:finora/presentation/sign_up/view_model/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileImage extends StatelessWidget {
  EditProfileImage({super.key, required this.user});

  final User user;
  final editUserProfileImageController = Get.find<UpdateUserProfileViewModel>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ProfileAndFullNameUserImage.setStateUserProfile(user),
        Container(
          margin: const EdgeInsets.only(top: circleAvatarRadius * 1.5),

          width: (circleAvatarRadius * 2) + 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                onPressed: () {
                  removeProfileImage();
                },
                icon: const CircleAvatar(
                  backgroundColor: kPrimaryColor,
                  child: Icon(Icons.cancel, color: kSecondColor),
                ),
              ),
              IconButton(
                onPressed: () {
                  changeProfileImage();
                },
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

  void changeProfileImage() async {
    final currentUser = AuthController.to.currentUser;
    if (currentUser == null) {
      return;
    }
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      await editUserProfileImageController.submitUpdatedInfo(
        imageProfilePath: image.path,
      );
    }
  }

  void removeProfileImage() async {
    final currentUser = AuthController.to.currentUser;
    if (currentUser == null) {
      return;
    }
    await editUserProfileImageController.submitUpdatedInfo(
      imageProfilePath: null,
    );
  }
}
