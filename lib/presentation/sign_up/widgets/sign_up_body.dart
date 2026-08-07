import 'package:finora/presentation/sign_up/widgets/custome_sign_up_data_container.dart';
import 'package:finora/presentation/sign_up/widgets/many_circles_container.dart';
import 'package:finora/presentation/sign_up/widgets/welcome_message_sign_up.dart';
import 'package:flutter/material.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        ManyCirclesContainer(body: WelcomeMessageForSignUp()),
        CustomeSignUpDataContainer(),
      ],
    );
  }
}
