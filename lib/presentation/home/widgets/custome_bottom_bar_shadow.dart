import 'package:finora/core/constants.dart';
import 'package:finora/presentation/home/widgets/clipper_shadow_painter.dart';

import 'package:finora/presentation/home/widgets/custome_bottom_app_bar_clipper.dart';
import 'package:flutter/material.dart';

class CustomeBottomBarShadow extends StatelessWidget {
  const CustomeBottomBarShadow({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomPaint(
      painter: ClipperShadowPainter(
        clipper: CustomeBottomAppBarClipper(),
        shadow: Shadow(blurRadius: blurRadius, color: Colors.grey),
      ),
      child: SizedBox(height: bottomAppBarHeight, width: double.infinity),
    );
  }
}
