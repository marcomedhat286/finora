import 'package:finora/presentation/screens/view_account/widgets/option_button.dart';
import 'package:flutter/material.dart';

class AccountOptionButtons extends StatelessWidget {
  const AccountOptionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      children: [
        const OptionButton(option: "update"),
        const SizedBox(width: 10),
        const OptionButton(option: "delete"),
      ],
    );
  }
}
