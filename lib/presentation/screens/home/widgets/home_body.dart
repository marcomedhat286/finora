import 'package:finora/presentation/screens/home/widgets/animated_options_widget.dart';
import 'package:finora/presentation/screens/home/widgets/balance_card.dart';

import 'package:finora/presentation/screens/home/widgets/home_bar.dart';
import 'package:finora/presentation/screens/home/widgets/list_transaction_view.dart';

import 'package:finora/presentation/screens/sign_up/widgets/many_circles_container.dart';
import 'package:flutter/material.dart';
import 'package:finora/presentation/screens/home/widgets/custome_bottom_app_bar.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        ManyCirclesContainer(body: HomeBar()),
        BalanceCard(),
        Align(
          alignment: AlignmentGeometry.xy(0, 0.68),
          child: RecentTransactions(),
        ),
        Positioned(left: 143, bottom: 85, child: AnimatedOptionsWidget()),
        CustomeBotttomAppBar(),
      ],
    );
  }
}
