import 'package:finora/presentation/home/widgets/balance_card.dart';
import 'package:finora/presentation/home/widgets/custome_f_a_b.dart';

import 'package:finora/presentation/home/widgets/home_bar.dart';

import 'package:finora/presentation/sign_up/widgets/many_circles_container.dart';
import 'package:flutter/material.dart';
import 'package:finora/presentation/home/widgets/custome_bottom_app_bar.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ManyCirclesContainer(body: HomeBar()),
        const BalanceCard(),
        const CustomeBotttomAppBar(),
        const Align(
          alignment: AlignmentGeometry.center,
          child: Row(children: [Text("Transaction History")]),
        ),
        CustomeFAB(
          onPressed: () {
            print("add");
          },
        ),
      ],
    );
  }
}
