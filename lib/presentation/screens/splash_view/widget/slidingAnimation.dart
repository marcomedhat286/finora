import 'package:flutter/material.dart';

class AnimatedWidget extends StatelessWidget {
  const AnimatedWidget({
    super.key,
    required this.slidingAnimation,
    required this.widget,
  });

  final Animation<Offset> slidingAnimation;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slidingAnimation,
      builder: (context, _) {
        return SlideTransition(position: slidingAnimation, child: widget);
      },
    );
  }
}
