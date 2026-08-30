import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';

class CheckDefaultAccount extends StatelessWidget {
  const CheckDefaultAccount({
    super.key,
    required this.onChanged,
    required this.defaultValue,
  });

  final void Function(bool?)? onChanged;
  final bool? defaultValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        const Text(
          'Set this one as default account',
          style: TextStyle(
            fontSize: smallSizeFont,
            fontWeight: FontWeight.w400,
          ),
        ),
        Checkbox(
          value: defaultValue,
          activeColor: kPrimaryColor,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
