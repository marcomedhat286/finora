import 'package:finora/core/constants.dart';
import 'package:finora/presentation/home/widgets/custome_bottom_app_bar_clipper.dart';
import 'package:finora/presentation/home/widgets/custome_bottom_bar_shadow.dart';

import 'package:finora/presentation/home/widgets/options_app_bar.dart';
import 'package:flutter/material.dart';

class CustomeBotttomAppBar extends StatelessWidget {
  const CustomeBotttomAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    const double circuleRadius = 15;

    return Align(
      alignment: AlignmentGeometry.bottomCenter,
      child: Stack(
        children: [
          const CustomeBottomBarShadow(),
          // const CustomeFAB(),
          ClipPath(
            clipper: const CustomeBottomAppBarClipper(),
            child: Container(
              height: bottomAppBarHeight,
              decoration: const BoxDecoration(
                color: kSecondColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(circuleRadius),
                  topRight: Radius.circular(circuleRadius),
                ),
              ),
              child: const OptionsAppBar(),
            ),
          ),
        ],
      ),
    );
  }
}
