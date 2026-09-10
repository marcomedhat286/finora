import 'package:finora/presentation/screens/display_all_accounts/widgets/add_account_top_text.dart';
import 'package:finora/presentation/screens/display_all_accounts/widgets/all_user_accounts_card.dart';
import 'package:finora/presentation/screens/home/widgets/custome_bottom_app_bar.dart';
import 'package:finora/presentation/screens/home/widgets/custome_f_a_b.dart';
import 'package:finora/presentation/screens/sign_up/widgets/many_circles_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisplayAllAccountsBody extends StatelessWidget {
  const DisplayAllAccountsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ManyCirclesContainer(body: AddAccountTopText()),
        const AllUserAccountsCard(),
        const CustomeBotttomAppBar(),
        Positioned(
          left: 143,
          bottom: 85,
          child: CustomeFAB(
            onPressed: () {
              Get.toNamed("/addaccount");
            },
          ),
        ),
      ],
    );
  }
}
