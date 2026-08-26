import 'package:finora/core/utils/assets.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(AssetsData.logo, height: 200);
  }
}
