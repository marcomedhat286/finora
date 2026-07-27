import 'package:finora/core/constants.dart';
import 'package:finora/presentation/welcome/widget/welcome_body.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: kPrimaryColor, body: WelcomeBody());
  }
}
