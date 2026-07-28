import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomeAppBar extends StatelessWidget {
  const CustomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 40, 0, 0),
      child: Row(
        spacing: 70,
        children: [
          IconButton(
            onPressed: () {
              print("back");
            },
            icon: FaIcon(FontAwesomeIcons.angleLeft, color: kSecondColor),
          ),
          Text(
            "Sign Up",
            style: TextStyle(
              color: kSecondColor,
              fontSize: middleSizeFont,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: () {
              print("options");
            },
            icon: FaIcon(FontAwesomeIcons.ellipsis, color: kSecondColor),
          ),
        ],
      ),
    );
  }
}
