import 'package:finora/core/constants.dart';
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
        SizedBox(
          width: 170,
          child: Text(
            title,
            overflow: .ellipsis,
            textAlign: .left,
            style: const TextStyle(
              color: Colors.white,
              fontSize: smallSizeFont + 1,
              fontFamily: 'Courier',
              letterSpacing: 1.2,
              fontWeight: .w700,
            ),
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
            fontWeight: .bold,
          ),
        ),
      ],
    );
  }

  String _formatedCardId(String id) => id.split('-').last;
}
