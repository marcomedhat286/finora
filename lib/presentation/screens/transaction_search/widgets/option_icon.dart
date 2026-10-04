import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OptionIcon extends StatelessWidget {
  const OptionIcon({super.key, required this.icon, required this.color});

  final FaIconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radiusIcon * 1.2,
      height: radiusIcon * 1.2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withAlpha(50),
      ),
      child: Center(
        child: FaIcon(icon, size: radiusIcon / 1.5, color: color),
      ),
    );
  }
}
