import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/login/widgets/login_body.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: kSecondColor, body: LoginBody());
  }
}
