import 'package:finora/core/constants.dart';
import 'package:finora/presentation/edit_profile/view/view.dart';
import 'package:finora/presentation/home/widgets/custome_bottom_app_bar.dart';
import 'package:finora/presentation/home/widgets/custome_f_a_b.dart';
import 'package:finora/presentation/profile/widgets/information_card.dart';
import 'package:finora/presentation/profile/widgets/profile_text_widget.dart';
import 'package:finora/presentation/profile/widgets/profile_user_image.dart';
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
            navigateToEditScreen();
          },
        ),
      ],
    );
  }

  void navigateToEditScreen() {
    Get.to(
      () => EditUserProfile(),
      transition: Transition.fade,
      duration: Duration(seconds: kTranstionDuration),
    );
  }
}
