import 'package:finora/presentation/sign_up/widgets/custome_app_bar.dart';
import 'package:finora/presentation/sign_up/widgets/small_text_message.dart';
import 'package:finora/presentation/sign_up/widgets/welcome_message.dart';
import 'package:flutter/material.dart';

class WelcomeMessageForSignUp extends StatelessWidget {
  const WelcomeMessageForSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomeAppBar(screenName: "Sign Up"),
        WelcomeMessage(),
        SmallTextMessage(
          message:
              "Sign up to organize your finances and achieve your financial goals",
        ),
      ],
    );
  }
}
