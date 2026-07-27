import 'package:finora/presentation/welcome/widget/circle_container.dart';
import 'package:finora/presentation/welcome/widget/clipped_container.dart';
import 'package:finora/presentation/welcome/widget/human_image.dart';
import 'package:finora/presentation/welcome/widget/top_circled_container.dart';
import 'package:finora/presentation/splash_view/widget/sliding_animation.dart';

import 'package:flutter/material.dart';

class WelcomeBody extends StatefulWidget {
  const WelcomeBody({super.key});

  @override
  State<WelcomeBody> createState() => _WelcomeBodyState();
}

class _WelcomeBodyState extends State<WelcomeBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimationCircles;
  late Animation<Offset> slidingAnimationHuman;
  late Animation<Offset> slidingAnimationClippedContainer;
  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      alignment: AlignmentGeometry.xy(0, -0.5),
      children: [
        SlidingAnimatedWidget(
          slidingAnimation: slidingAnimationCircles,
          widget: TopCircledContainer(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            dyRatio: .15,
          ),
        ),
        SlidingAnimatedWidget(
          slidingAnimation: slidingAnimationCircles,
          widget: TopCircledContainer(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            dyRatio: 0.2,
            cutHeight: 250,
          ),
        ),

        SlidingAnimatedWidget(
          slidingAnimation: slidingAnimationCircles,
          widget: CircleContainer(screenWidth: screenWidth - 50),
        ),

        SlidingAnimatedWidget(
          slidingAnimation: slidingAnimationClippedContainer,
          widget: ClippedContainer(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
          ),
        ),
        SlidingAnimatedWidget(
          slidingAnimation: slidingAnimationHuman,
          widget: const HumanImage(),
        ),
      ],
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );

    slidingAnimationCircles =
        Tween<Offset>(begin: const Offset(0, 5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0, 0.4),
          ),
        );

    slidingAnimationHuman =
        Tween<Offset>(begin: const Offset(0, 5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.3, 0.7),
          ),
        );

    slidingAnimationClippedContainer =
        Tween<Offset>(begin: const Offset(0, 5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.6, 1),
          ),
        );
    animationController.forward();
  }
}
