import 'package:finora/core/constants.dart';

import 'package:finora/presentation/screens/home/widgets/not_found_image_icon.dart';
import 'package:flutter/material.dart';

class NotFoundAccountOrTransaction extends StatelessWidget {
  const NotFoundAccountOrTransaction({
    super.key,
    required this.message,
    this._name = "Transactions",
  });
  final String _name;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: .center,
        mainAxisAlignment: .start,
        children: [
          const NotFoundImageIcon(),
          Text(
            'No $_name Found',
            style: const TextStyle(
              color: kPrimaryColor2,
              fontSize: smallSizeFont * 1.4,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            message ?? 'Add new $_name to view it here.',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: smallSizeFont,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
