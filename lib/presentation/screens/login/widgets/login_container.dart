import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/login/widgets/login_container_body.dart';
import 'package:flutter/material.dart';

class LoginContainer extends StatelessWidget {
  const LoginContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.xy(0, 1),
      child: Container(
        height: 350,
        alignment: AlignmentGeometry.topCenter,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
        decoration: const BoxDecoration(
          color: kSecondColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: const LoginContainerBody(),
      ),
    );
  }
}
