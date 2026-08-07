import 'package:finora/presentation/sign_up/view_model/auth_controller.dart';
import 'package:finora/presentation/sign_up/widgets/many_circles_container.dart';
import 'package:flutter/material.dart';
import 'package:finora/presentation/home/widgets/bottom_custome_app_bar.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthController.to.currentUser;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        ManyCirclesContainer(
          body: Center(child: Text("welcome ${user!.fullName}")),
        ),

        BotttomCustomeAppBar(currentIndex: 0),
      ],
    );
  }
}
