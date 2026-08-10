import 'package:finora/core/constants.dart';
import 'package:finora/domain/entities/user.dart';
import 'package:finora/presentation/edit_profile/view.dart';
import 'package:finora/presentation/home/widgets/custome_bottom_app_bar.dart';
import 'package:finora/presentation/home/widgets/custome_f_a_b.dart';
import 'package:finora/presentation/profile/widgets/profile_text_widget.dart';
import 'package:finora/presentation/profile/widgets/profile_user_image.dart';
import 'package:finora/presentation/sign_up/view_model/auth_controller.dart';
import 'package:finora/presentation/sign_up/widgets/many_circles_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ManyCirclesContainer(body: ProfileTextWidget()),
        const InformationCard(),
        const ProfileAndFullNameUserImage(),
        const CustomeBotttomAppBar(),
        CustomeFAB(
          onPressed: () {
            Get.to(EditUserProfile());
          },
        ),
        // Center(child: Text("$user")),
      ],
    );
  }
}

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
          padding: const EdgeInsets.only(top: 80.0, bottom: 150),
          child: SingleChildScrollView(
            child: Obx(() {
              final user = AuthController.to.currentUser;
              return Column(
                children: [
                  RowCardPresentationInfo(
                    dataName: "User Name:",
                    data: user!.userName.value,
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
                  RowCardPresentationInfo(
                    dataName: "Account ID",
                    data: user.account.id,
                  ),
                  const SizedBox(height: 4),
                  RowCardPresentationInfo(
                    dataName: "Created At",
                    data: user.createdAt.toString(),
                  ),
                  const SizedBox(height: 4),
                  RowCardPresentationInfo(
                    dataName: "Image Profile Path",
                    data: "${user.image.path}",
                  ),
                  const SizedBox(height: 4),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

class RowCardPresentationInfo extends StatelessWidget {
  const RowCardPresentationInfo({
    super.key,

    required this.data,
    required this.dataName,
  });
  final String dataName;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.grey.shade300, width: 2),
        ),
      ),
      child: OneDataPresentationRowWidget(dataName: dataName, data: data),
    );
  }
}

class OneDataPresentationRowWidget extends StatelessWidget {
  const OneDataPresentationRowWidget({
    super.key,

    required this.data,
    required this.dataName,
  });

  final String dataName;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          dataName,
          style: const TextStyle(
            fontSize: smallSizeFont,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          data,
          style: const TextStyle(
            fontSize: smallSizeFont,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
