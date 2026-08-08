import 'package:finora/presentation/home/view_model.dart/bottom_app_bar_controller.dart';
import 'package:finora/presentation/home/widgets/balance_card.dart';
import 'package:finora/presentation/home/widgets/custome_f_a_b.dart';

import 'package:finora/presentation/home/widgets/home_bar.dart';

import 'package:finora/presentation/sign_up/widgets/many_circles_container.dart';
import 'package:flutter/material.dart';
import 'package:finora/presentation/home/widgets/custome_bottom_app_bar.dart';

import 'package:get/get.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BottomAppBarController());
    return Stack(
      children: [
        ManyCirclesContainer(body: const HomeBar()),
        const BalanceCard(),
        const CustomeBotttomAppBar(currentIndex: 0),
        const CustomeFAB(),
      ],
    );
  }
}
