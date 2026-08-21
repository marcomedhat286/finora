import 'package:finora/core/constants.dart';

import 'package:finora/presentation/edit_profile/view_model/update_user_profile_view_model.dart';
import 'package:finora/presentation/edit_profile/widgets/edit_user_profile.dart';
import 'package:finora/presentation/edit_profile/widgets/save_changes_button.dart';
import 'package:finora/presentation/sign_up/view_model/auth_user_controller.dart';
import 'package:finora/presentation/sign_up/widgets/custome_app_bar.dart';
import 'package:finora/presentation/sign_up/widgets/custome_date_picker.dart';
import 'package:finora/presentation/sign_up/widgets/custome_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditUserInfoBody extends StatelessWidget {
  const EditUserInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthUserController.to.currentUser;
    if (user == null) return const SizedBox();

    final editInfoController = Get.find<UpdateUserProfileViewModel>();

    final firstNameTextFeildController = TextEditingController(
      text: user.firstName.value,
    );
    final middleNameTextFeildController = TextEditingController(
      text: user.middleName?.value,
    );
    final lastNameTextFeildController = TextEditingController(
      text: user.lastName?.value,
    );
    // final initialBalanceTextFeildController = TextEditingController(
    //   text: "${user.account.initialBalance.value}",
    // );
    final userNameTextFeildController = TextEditingController(
      text: user.userName.value,
    );
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            CustomeAppBar(
              screenName: "Update Profile Info",
              color: kPrimaryColor2,
            ),
            const SizedBox(height: 20),
            EditProfileImage(user: user),
            CustomeTextField(
              dataName: "first name",
              prefixIcon: Icons.abc,
              textEditingController: firstNameTextFeildController,
              errorText: editInfoController.firstNameError.value,
            ),
            CustomeTextField(
              dataName: "middle name",
              prefixIcon: Icons.abc,
              textEditingController: middleNameTextFeildController,
              errorText: editInfoController.middleNameError.value,
            ),
            CustomeTextField(
              dataName: "last name",
              prefixIcon: Icons.abc,
              textEditingController: lastNameTextFeildController,
              errorText: editInfoController.lastNameError.value,
            ),
            CustomeDatePickerField(
              dataName: "Birthday",
              initialDate: user.birthdayDate.value,
              errorText: editInfoController.birthDateError.value,
              onDateSelected: editInfoController.setBirthDate,
            ),
            // CustomeTextField(
            //   dataName: "initial balance",
            //   prefixIcon: Icons.attach_money_outlined,
            //   textEditingController: initialBalanceTextFeildController,
            //   errorText: editInfoController.initialBalanceError.value,
            // ),
            CustomeTextField(
              dataName: "user name",
              prefixIcon: Icons.abc,
              textEditingController: userNameTextFeildController,
              errorText: editInfoController.userNameError.value,
            ),
            // SaveChangesButton(
            //   firstName: firstNameTextFeildController,
            //   middleName: middleNameTextFeildController,
            //   lastName: lastNameTextFeildController,
            //   birthdayDate: editInfoController.birthDate.value,
            //   initialBalance: initialBalanceTextFeildController,
            //   userName: userNameTextFeildController,
            // ),
            const SizedBox(height: 30),
          ],
        ),
      );
    });
  }
}
