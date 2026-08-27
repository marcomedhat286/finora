import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/home/view_model.dart/bottom_app_bar_controller.dart';
import 'package:finora/presentation/screens/home/widgets/home_body.dart';
import 'package:finora/presentation/screens/profile/widgets/profile_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final pages = [const HomeBody(), Scaffold(), Scaffold(), const ProfileBody()];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BottomAppBarController>();

    return Scaffold(
      backgroundColor: kSecondColor,
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndexOptions.value,
          children: pages,
        ),
      ),
    );
  }
}
