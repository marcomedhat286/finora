import 'package:finora/presentation/home/view_model.dart/bottom_app_bar_controller.dart';
import 'package:finora/presentation/home/widgets/home_body.dart';
import 'package:finora/presentation/profile/widgets/profile_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final pages = [const HomeBody(), Scaffold(), Scaffold(), const ProfileBody()];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomAppBarController());

    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndexOptions.value,
          children: pages,
        ),
      ),
    );
  }
}
