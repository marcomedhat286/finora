import 'package:finora/core/utils/assets.dart';
import 'package:flutter/material.dart';

class HumanImage extends StatelessWidget {
  const HumanImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(AssetsData.human);
  }
}
