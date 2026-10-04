import 'package:finora/core/constants.dart';
import 'package:finora/presentation/screens/view_account/view_model/get_list_view_account_transactoin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeeMoreButton extends StatelessWidget {
  const SeeMoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GetListViewAccountTransactoinController>();
    return TextButton(
      onPressed: () async {
        await controller.showMoreTransactionAccountAction();
      },
      child: Obx(
        () => Text(
          (!controller.hideState.value)
              ? "see more".toUpperCase()
              : "hide".toUpperCase(),
          style: const TextStyle(
            color: kPrimaryColor2,
            fontWeight: .bold,
            fontSize: smallSizeFont,
          ),
        ),
      ),
    );
  }
}
