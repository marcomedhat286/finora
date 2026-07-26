import 'package:finora/presentation/screens/splash_view/widget/logo.dart';
import 'package:flutter/material.dart';

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({super.key, required this.slidingAnimationLogo});

  final Animation<Offset> slidingAnimationLogo;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slidingAnimationLogo,
      builder: (context, _) {
        return SlideTransition(
          position: slidingAnimationLogo,
          child: const Logo(),
        );
      },
    );
  }
}
