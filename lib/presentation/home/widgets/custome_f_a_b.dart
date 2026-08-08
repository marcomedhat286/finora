import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';

class CustomeFAB extends StatelessWidget {
  const CustomeFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 143,
      bottom: 85,
      child: SizedBox(
        height: circleBottonSize,
        width: circleBottonSize,
        child: FloatingActionButton(
          onPressed: () {
            print("add");
          },
          shape: CircleBorder(),
          backgroundColor: kPrimaryColor,
          child: Icon(
            Icons.add,
            color: kSecondColor,
            size: circleBottonSize / 2,
          ),
        ),
      ),
    );
  }
}
