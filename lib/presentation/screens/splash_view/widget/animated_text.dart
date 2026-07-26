import 'package:finora/presentation/screens/splash_view/widget/app_name_text.dart';
import 'package:flutter/material.dart';

class AnimatedText extends StatelessWidget {
  const AnimatedText({super.key, required this.downTopAnimationText});

  final Animation<Offset> downTopAnimationText;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: downTopAnimationText,
      builder: (context, _) {
        return SlideTransition(
          position: downTopAnimationText,
          child: const AppNameText(),
        );
      },
    );
  }
}
