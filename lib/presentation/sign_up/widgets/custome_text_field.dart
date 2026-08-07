import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';

class CustomeTextField extends StatelessWidget {
  const CustomeTextField({
    super.key,
    required this.dataName,
    required this.hinitMessage,
    required this.prefixIcon,
    required this.textEditingController,
    required this.errorText,
  });
  final String? errorText;
  final String dataName;
  final String hinitMessage;
  final IconData prefixIcon;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    const double circleBorderRadius = 10;
    final textStyle = TextStyle(
      color: Colors.grey.withAlpha(alphaValue * 4),
      fontSize: smallSizeFont,
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(dataName.toUpperCase(), style: textStyle),
          const SizedBox(height: 10),
          TextField(
            controller: textEditingController,
            style: const TextStyle(color: kPrimaryColor),
            decoration: InputDecoration(
              hintText: hinitMessage,
              hintStyle: textStyle,
              hintMaxLines: 3,
              prefixIcon: Icon(prefixIcon),
              prefixIconColor: kPrimaryColor,
              errorText: errorText,
              errorMaxLines: 3,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(circleBorderRadius),
                borderSide: const BorderSide(color: Colors.grey),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(circleBorderRadius),
                borderSide: const BorderSide(color: kPrimaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
