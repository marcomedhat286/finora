import 'package:finora/core/constants.dart';
import 'package:finora/presentation/welcome/view/welcome_screen.dart';
import 'package:finora/presentation/splash_view/widget/sliding_animation.dart';

import 'package:finora/presentation/splash_view/widget/app_name_text.dart';
import 'package:finora/presentation/splash_view/widget/logo.dart';
import 'package:flutter/widgets.dart';

import 'package:get/route_manager.dart';

class SplachViewBody extends StatefulWidget {
  const SplachViewBody({super.key});

  @override
  State<SplachViewBody> createState() => _SplachViewBodyState();
}

class _SplachViewBodyState extends State<SplachViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimationLogo;
  late Animation<Offset> slidingAnimationText;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    navigateToWelcome();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SlidingAnimatedWidget(
          slidingAnimation: slidingAnimationLogo,
          widget: Logo(),
        ),
        SlidingAnimatedWidget(
          slidingAnimation: slidingAnimationText,
          widget: AppNameText(),
        ),
      ],
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    slidingAnimationLogo =
        Tween<Offset>(begin: const Offset(0, 5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.0, 1),
          ),
        );
    slidingAnimationText =
        Tween<Offset>(begin: const Offset(0, 5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.2, 1),
          ),
        );
    animationController.forward();
  }

  void navigateToWelcome() {
    Future.delayed(const Duration(seconds: 4), () {
      Get.to(
        () => const Welcome(),
        transition: Transition.fadeIn,
        duration: const Duration(seconds: kTranstionDuration),
      );
    });
  }
}
