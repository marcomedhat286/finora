import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';

class CurrentAndDateCard extends StatelessWidget {
  const CurrentAndDateCard({
    super.key,
    required this.currentBalance,
    required this.createdAt,
  });

  final String currentBalance;
  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "$currentBalance \$",
          style: const TextStyle(
            color: Colors.white,
            fontSize: smallSizeFont,
            fontFamily: 'Courier',
            letterSpacing: 1.5,
          ),
        ),

        const SizedBox(height: 12),

        // Card number
        Text(
          _formatedCardDate(createdAt),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Courier',
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  String _formatedCardDate(DateTime date) => "${date.day}/${date.month}";
}
