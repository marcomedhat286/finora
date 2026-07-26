import 'package:finora/presentation/screens/splash_view/widget/animated_logo.dart';
import 'package:finora/presentation/screens/splash_view/widget/animated_text.dart';
import 'package:flutter/widgets.dart';

class SplachViewBody extends StatefulWidget {
  const SplachViewBody({super.key});

  @override
  State<SplachViewBody> createState() => _SplachViewBodyState();
}

class _SplachViewBodyState extends State<SplachViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> downTopAnimationLogo;
  late Animation<Offset> downTopAnimationText;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    downTopAnimationLogo =
        Tween<Offset>(begin: const Offset(0, 5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.0, 1),
          ),
        );
    downTopAnimationText =
        Tween<Offset>(begin: const Offset(0, 5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.2, 1),
          ),
        );
    animationController.forward();
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
        AnimatedLogo(downTopAnimationLogo: downTopAnimationLogo),
        AnimatedText(downTopAnimationText: downTopAnimationText),
      ],
    );
  }
}
