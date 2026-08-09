import 'package:finora/presentation/home/widgets/custome_bottom_app_bar.dart';
import 'package:finora/presentation/home/widgets/custome_f_a_b.dart';
import 'package:finora/presentation/profile/widgets/profile_text_widget.dart';
import 'package:finora/presentation/profile/widgets/profile_user_image.dart';
import 'package:finora/presentation/sign_up/view_model/auth_controller.dart';
import 'package:finora/presentation/sign_up/widgets/many_circles_container.dart';
import 'package:flutter/material.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthController.to.currentUser;
    return Stack(
      children: [
        const ManyCirclesContainer(),
        const ProfileTextWidget(),
        const ProfileAndFullNameUserImage(),
        const CustomeBotttomAppBar(),

        CustomeFAB(
          onPressed: () {
            print("edit");
          },
        ),
        Center(child: Text("$user")),
      ],
    );
  }
}
