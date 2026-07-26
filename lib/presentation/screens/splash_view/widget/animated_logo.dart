import 'package:finora/presentation/screens/splash_view/widget/logo.dart';
import 'package:flutter/material.dart';

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({super.key, required this.downTopAnimationLogo});

  final Animation<Offset> downTopAnimationLogo;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: downTopAnimationLogo,
      builder: (context, _) {
        return SlideTransition(
          position: downTopAnimationLogo,
          child: const Logo(),
        );
      },
    );
  }
}
