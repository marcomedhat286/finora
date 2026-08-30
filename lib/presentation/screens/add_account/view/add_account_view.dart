import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/add_account/widgets/add_account_body.dart';
import 'package:flutter/material.dart';

class AddAccountView extends StatelessWidget {
  const AddAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AddAccountBody(),
      backgroundColor: kSecondColor,
    );
  }
}
