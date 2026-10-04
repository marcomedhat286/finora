import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/display_all_accounts/display_all_accounts_body/display_all_accounts_body.dart';
import 'package:finora/presentation/screens/home/view_model.dart/bottom_app_bar_controller.dart';
import 'package:finora/presentation/screens/home/widgets/home_body.dart';
import 'package:finora/presentation/screens/profile/widgets/profile_body.dart';
import 'package:finora/presentation/screens/transaction_search/body/transaction_search_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final pages = [
    const HomeBody(),
    const DisplayAllAccountsBody(),
    const TransactionSearchBody(),
    const ProfileBody(),
  ];

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
