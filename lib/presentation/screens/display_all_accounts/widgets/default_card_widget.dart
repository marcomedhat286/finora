import 'package:flutter/material.dart';

class DefaultCardWidget extends StatelessWidget {
  const DefaultCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -15,
      left: 145,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.amber.shade700,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'DEFAULT',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}
