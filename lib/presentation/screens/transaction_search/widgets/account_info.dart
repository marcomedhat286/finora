import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({
    super.key,
    required this.accountName,
    required this.accountCurrentBalacne,
    required this.accountType,
  });

  final String accountName;
  final String? accountType;
  final double? accountCurrentBalacne;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .spaceBetween,
      crossAxisAlignment: .start,
      children: [
        Text(
          accountName,
          style: const TextStyle(
            fontSize: smallSizeFont * 1.2,
            fontWeight: .bold,
          ),
        ),
        const SizedBox(height: 5),
        (accountType != null)
            ? Text(
                accountType!,
                style: const TextStyle(fontSize: smallSizeFont),
              )
            : const SizedBox.shrink(),
        const SizedBox(height: 5),
        (accountCurrentBalacne != null)
            ? Text(
                "$accountCurrentBalacne EG",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: smallSizeFont,
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
