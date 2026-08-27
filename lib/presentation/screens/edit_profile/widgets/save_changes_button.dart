import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/edit_profile/view_model/update_user_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SaveChangesButton extends StatelessWidget {
  final controller = Get.find<UpdateUserInfoViewModel>();
  SaveChangesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: ElevatedButton(
        onPressed: () async {
          await controller.submitUpdate();
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
