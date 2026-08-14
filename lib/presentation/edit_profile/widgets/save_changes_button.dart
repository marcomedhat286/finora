import 'package:finora/core/constants.dart';
import 'package:finora/presentation/edit_profile/view_model/update_user_profile_view_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SaveChangesButton extends StatelessWidget {
  final controller = Get.find<UpdateUserProfileViewModel>();
  SaveChangesButton({
    super.key,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.initialBalance,
    required this.userName,
    this.birthdayDate,
  });

  final TextEditingController firstName;
  final TextEditingController middleName;
  final TextEditingController lastName;
  final TextEditingController initialBalance;
  final TextEditingController userName;
  final DateTime? birthdayDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: ElevatedButton(
        onPressed: () async {
          await controller.submitUpdatedInfo(
            firstName: firstName.text,
            middleName: (middleName.text.isEmpty) ? null : middleName.text,
            lastName: (lastName.text.isEmpty) ? null : lastName.text,
            birthDate: birthdayDate,
          );
          await controller.sumbitChangeUserName(newUserName: userName.text);
          await controller.sumbitChangeInitalBalance(
            initalBalance: initialBalance.text,
          );
        },

        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          fixedSize: const Size(250, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Obx(() => _returnButtonState),
      ),
    );
  }

  Widget get _returnButtonState {
    return (controller.isLoading.value)
        ? LoadingAnimationWidget.staggeredDotsWave(
            color: kSecondColor,
            size: 30,
          )
        : const Text(
            "Save Changes",
            style: TextStyle(color: kSecondColor, fontSize: smallSizeFont),
            textAlign: TextAlign.center,
          );
  }
}
