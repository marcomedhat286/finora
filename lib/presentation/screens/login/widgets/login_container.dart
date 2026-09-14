import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/login/widgets/login_container_body.dart';
import 'package:flutter/material.dart';

class LoginContainer extends StatelessWidget {
  const LoginContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      alignment: AlignmentGeometry.topCenter,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: kSecondColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: const LoginContainerBody(),
    );
  }
}
