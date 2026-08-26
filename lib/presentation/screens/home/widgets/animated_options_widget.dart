import 'package:finora/presentation/screens/home/widgets/add_transaction_button.dart';
import 'package:finora/presentation/screens/home/widgets/custome_f_a_b.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AnimatedOptionsWidget extends StatefulWidget {
  const AnimatedOptionsWidget({super.key});

  @override
  State<AnimatedOptionsWidget> createState() => AnimatedOptionsWidgetState();
}

class AnimatedOptionsWidgetState extends State<AnimatedOptionsWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _option1Slide;
  late final Animation<Offset> _option2Slide;
  late final Animation<double> _option1Fade;
  late final Animation<double> _option2Fade;
  bool isOpen = false;
  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeTransition(
          opacity: _option1Fade,
          child: SlideTransition(
            position: _option1Slide,
            child: AddTransactionButton(
              icon: FontAwesomeIcons.moneyBill1,
              text: "Add Income",
              onPressed: () {
                Get.toNamed("/addincome");
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        FadeTransition(
          opacity: _option2Fade,
          child: SlideTransition(
            position: _option2Slide,
            child: AddTransactionButton(
              icon: FontAwesomeIcons.receipt,
              text: "Add Expense",
              onPressed: () {
                Get.toNamed("/addexpense");
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        CustomeFAB(
          onPressed: () {
            toggleMenu();
          },
        ),
      ],
    );
  }

  void initSlidingAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _option1Slide = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0, 0.4),
          ),
        );

    _option2Slide = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.3, 0.7),
          ),
        );

    _option1Fade = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    );

    _option2Fade = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.35, 1.0, curve: Curves.easeIn),
    );
  }

  void toggleMenu() {
    setState(() {
      isOpen = !isOpen;
    });

    if (isOpen) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }
}
