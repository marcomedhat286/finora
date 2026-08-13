import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';

class OneDataPresentationRowWidget extends StatelessWidget {
  const OneDataPresentationRowWidget({
    super.key,

    required this.data,
    required this.dataName,
  });

  final String dataName;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          dataName,
          style: const TextStyle(
            fontSize: smallSizeFont,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          width: 150,
          child: Text(
            data,
            textAlign: TextAlign.right,
            style: const TextStyle(
              overflow: TextOverflow.fade,
              fontSize: smallSizeFont,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
