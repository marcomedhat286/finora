import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';

class NoTransactionTextWidget extends StatelessWidget {
  const NoTransactionTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(top: 40),
        child: Text(
          'No Transactions Yet',
          style: TextStyle(
            color: kPrimaryColor2,
            fontSize: smallSizeFont,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
