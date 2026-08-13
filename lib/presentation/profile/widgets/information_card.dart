import 'package:finora/core/constants.dart';
import 'package:finora/presentation/profile/widgets/row_card_presentation_info.dart';
import 'package:finora/presentation/sign_up/view_model/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformationCard extends StatelessWidget {
  const InformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.bottomCenter,
      child: Container(
        height: 570,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: kSecondColor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 130.0, bottom: 150),
          child: SingleChildScrollView(
            child: Obx(() {
              return setStateInformationCard();
            }),
          ),
        ),
      ),
    );
  }

  RenderObjectWidget setStateInformationCard() {
    final user = AuthController.to.currentUser;
    if (user == null) return const SizedBox();
    return Column(
      children: [
        RowCardPresentationInfo(
          dataName: "User Name:",
          data: user.userName.value,
        ),
        const SizedBox(height: 4),
        RowCardPresentationInfo(
          dataName: "Age",
          data: "${user.birthdayDate.age}",
        ),
        const SizedBox(height: 4),
        RowCardPresentationInfo(
          dataName: "Birthday Date",
          data: user.birthdayDate.formattedDate,
        ),
        const SizedBox(height: 4),
        RowCardPresentationInfo(
          dataName: "Initial Balance",
          data: "${user.account.initialBalance.value}",
        ),
        const SizedBox(height: 4),
        RowCardPresentationInfo(
          dataName: "Current Balance",
          data: "${user.account.currentBalance.value}",
        ),
        const SizedBox(height: 4),
        RowCardPresentationInfo(dataName: "Account ID", data: user.account.id),
        const SizedBox(height: 4),
        RowCardPresentationInfo(
          dataName: "Created At",
          data: user.createdAt.toString(),
        ),
        const SizedBox(height: 4),
        RowCardPresentationInfo(
          dataName: "Image Profile",
          data: "${user.profileImage.path?.split("/").last}",
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}
