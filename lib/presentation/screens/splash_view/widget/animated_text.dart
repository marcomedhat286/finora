import 'package:finora/presentation/screens/splash_view/widget/app_name_text.dart';
import 'package:flutter/material.dart';

class AnimatedText extends StatelessWidget {
  const AnimatedText({super.key, required this.slidingAnimationText});

  final Animation<Offset> slidingAnimationText;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slidingAnimationText,
      builder: (context, _) {
        return SlideTransition(
          position: slidingAnimationText,
          child: const AppNameText(),
        );
      },
    );
  }
}
