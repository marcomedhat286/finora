import 'package:finora/presentation/sign_up/view_model/sign_up_view_model.dart';
import 'package:finora/presentation/sign_up/widgets/custome_text_field.dart';
import 'package:finora/presentation/sign_up/widgets/previous_button.dart';
import 'package:finora/presentation/sign_up/widgets/sign_up_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserNameInfoWidget extends StatelessWidget {
  const UserNameInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignUpViewModel>();
    return Obx(() {
      return Column(
        children: [
          Text(
            "Enter new username, or click sign Up and we will generate new one for u but take look about it to use it in log in ",
            style: CustomeTextField.textStyleDataName,
          ),
          const SizedBox(height: 50),
          CustomeTextField(
            dataName: "username",
            hinitMessage: "EG. username_123",
            prefixIcon: Icons.verified,
            errorText: controller.userNameError.value,
            textEditingController: controller.userNameController,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [const PreviousButton(), SignUpButton()],
          ),
        ],
      );
    });
  }
}
