import 'package:flutter/material.dart';

class NameAndIdCard extends StatelessWidget {
  const NameAndIdCard({
    super.key,
    required this.title,
    required this.accountId,
  });

  final String title;
  final String accountId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Courier',
            letterSpacing: 1.5,
          ),
        ),

        const SizedBox(height: 12),

        // Card number
        Text(
          _formatedCardId(accountId),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontFamily: 'Courier',
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  String _formatedCardId(String id) => id.split('-').last;
}
