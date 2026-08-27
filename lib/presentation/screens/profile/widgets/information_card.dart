import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/profile/widgets/row_card_presentation_info.dart';
import 'package:finora/presentation/controller/auth_user_controller.dart';
import 'package:finora/presentation/screens/welcome/widget/clipper_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformationCard extends StatelessWidget {
  const InformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.bottomCenter,
      child: ClipPath(
        clipper: MyClipper(),
        child: Container(
          height: 570,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 150),
          color: kSecondColor,
          child: Obx(() {
            return setStateInformationCard();
          }),
        ),
      ),
    );
  }

  RenderObjectWidget setStateInformationCard() {
    final user = AuthUserController.to.currentUser;
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
          dataName: "Created At",
          data: _formatedDate(user.createdAt),
        ),
        const SizedBox(height: 4),
        RowCardPresentationInfo(
          dataName: "Image Profile",
          data: "${user.profileImage?.path.split("/").last}",
        ),
        const SizedBox(height: 4),
      ],
    );
  }

  String _formatedDate(DateTime date) =>
      "${date.day}/${date.month}/${date.year}";
}
