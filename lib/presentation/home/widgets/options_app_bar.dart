import 'package:finora/core/constants.dart';
import 'package:finora/presentation/home/view_model.dart/bottom_app_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class OptionsAppBar extends StatelessWidget {
  const OptionsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BottomAppBarController>();
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildItem(
              controller: controller,
              icon: FontAwesomeIcons.house,
              index: 0,
            ),
            _buildItem(
              controller: controller,
              icon: FontAwesomeIcons.wallet,
              index: 1,
            ),

            const SizedBox(width: 40),

            _buildItem(
              controller: controller,
              icon: FontAwesomeIcons.magnifyingGlass,
              index: 2,
            ),
            _buildItem(
              controller: controller,
              icon: FontAwesomeIcons.user,
              index: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem({
    required FaIconData icon,
    required int index,
    required BottomAppBarController controller,
  }) {
    return IconButton(
      onPressed: () {
        controller.changePage(index);
      },
      icon: FaIcon(
        icon,
        color: controller.currentIndexOptions.value == index
            ? kPrimaryColor
            : Colors.grey,
        size: circleBottonSize / 3.5,
      ),
    );
  }
}
