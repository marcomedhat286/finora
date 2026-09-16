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

  late final Animation<double> _option1Fade;

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
              text: "Add Transaction",
              onPressed: () async {
                await _openPage("/addtransaction");
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

    _option1Fade = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
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

  Future<void> _openPage(String route) async {
    await Get.toNamed(route);

    if (!mounted) return;

    if (isOpen) {
      toggleMenu();
    }
  }
}
