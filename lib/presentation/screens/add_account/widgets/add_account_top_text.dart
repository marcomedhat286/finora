import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/sign_up/widgets/custome_app_bar.dart';
import 'package:flutter/material.dart';

class AddAccountTopText extends StatelessWidget {
  const AddAccountTopText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomeAppBar(screenName: "Add Account"),
        SizedBox(height: 5),
        Text(
          "Add a new account and keep your finances organized."
          " Set your financial goals and stay in control of your money.",
          textAlign: TextAlign.center,
          style: TextStyle(color: kSecondColor, fontSize: smallSizeFont),
        ),
      ],
    );
  }
}
