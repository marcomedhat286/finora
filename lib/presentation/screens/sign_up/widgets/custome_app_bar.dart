import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomeAppBar extends StatelessWidget {
  const CustomeAppBar({
    super.key,
    required this.screenName,
    this.color = kSecondColor,
    this.needBack = true,
    this.option,
    this.onPress,
  });
  final String screenName;
  final Color color;
  final bool needBack;
  final FaIconData? option;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 35, 16, 0),
      child: Row(
        children: [
          needBack
              ? IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: FaIcon(FontAwesomeIcons.angleLeft, color: color),
                )
              : const SizedBox(width: 7),
          const Spacer(),
          Text(
            screenName,
            style: TextStyle(
              color: color,
              fontSize: middleSizeFont,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          (option != null)
              ? IconButton(
                  onPressed: onPress,
                  icon: FaIcon(option, color: color),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
