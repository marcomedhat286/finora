import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/login/widgets/login_container.dart';
import 'package:finora/presentation/screens/display_all_accounts/widgets/card_design_painter.dart';
import 'package:finora/presentation/screens/splash_view/widget/app_name_text.dart';
import 'package:finora/presentation/screens/splash_view/widget/logo.dart';
import 'package:flutter/material.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: 2,
          colors: defaultColors,
          center: .topRight,
          focalRadius: 0.9,
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: CardDesignPainter())),

          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.manual,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [Logo(), AppNameText(), LoginContainer()],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
