import 'package:finora/core/constants.dart';
import 'package:finora/presentation/sign_up/view_model/sign_up_view_model.dart';
import 'package:finora/presentation/sign_up/widgets/account_info_step_widget.dart';
import 'package:finora/presentation/sign_up/widgets/personal_info_step_widegt.dart';
import 'package:finora/presentation/sign_up/widgets/username_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomeSignUpDataContainer extends StatelessWidget {
  const CustomeSignUpDataContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignUpViewModel>();
    return Align(
      alignment: AlignmentGeometry.bottomCenter,
      child: Container(
        height: 625,
        margin: const EdgeInsets.symmetric(horizontal: 25),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        decoration: const BoxDecoration(
          color: kSecondColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: blurRadius,
              spreadRadius: 5,
              offset: Offset(0, 15),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Obx(() {
            switch (controller.currentStep.value) {
              case 0:
                return const PersonalInfoStepWidegt();

              case 1:
                return const AccountInfoStepWidget();

              case 2:
                return const UserNameInfoWidget();

              default:
                return const SizedBox();
            }
          }),
        ),
      ),
    );
  }
}
