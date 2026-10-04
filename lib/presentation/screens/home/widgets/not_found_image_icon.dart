import 'package:finora/core/utils/assets.dart';
import 'package:flutter/material.dart';

class NotFoundImageIcon extends StatelessWidget {
  const NotFoundImageIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 150,
      child: Image.asset(AssetsData.notFoundIcon),
    );
  }
}
