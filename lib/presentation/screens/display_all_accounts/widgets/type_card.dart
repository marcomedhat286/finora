import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';

class TypeCard extends StatelessWidget {
  const TypeCard({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          type,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),

        Text(
          appName.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
