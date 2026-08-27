import 'package:finora/presentation/screens/edit_profile/view_model/update_user_profile_view_model.dart';
import 'package:finora/presentation/screens/edit_profile/widgets/edit_profile_image.dart';
import 'package:finora/presentation/screens/edit_profile/widgets/save_changes_button.dart';
import 'package:finora/presentation/screens/sign_up/widgets/custome_app_bar.dart';
import 'package:finora/presentation/screens/sign_up/widgets/custome_date_picker.dart';
import 'package:finora/presentation/screens/sign_up/widgets/custome_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisplayUpdatedUserInfo extends StatelessWidget {
  const DisplayUpdatedUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final editInfoController = Get.find<UpdateUserInfoViewModel>();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const CustomeAppBar(screenName: "Update Info"),
            const SizedBox(height: 20),
            const EditProfileImage(),
            CustomeTextField(
              dataName: "first name",
              prefixIcon: Icons.abc,
              textEditingController: editInfoController.firstNameController,
              errorText: editInfoController.firstNameError.value,
            ),
            CustomeTextField(
              dataName: "middle name",
              prefixIcon: Icons.abc,
              textEditingController: editInfoController.middleNameController,
              errorText: editInfoController.middleNameError.value,
            ),
            CustomeTextField(
              dataName: "last name",
              prefixIcon: Icons.abc,
              textEditingController: editInfoController.lastNameController,
              errorText: editInfoController.lastNameError.value,
            ),
            CustomeDatePickerField(
              dataName: "Birthday date",
              initialDate: editInfoController.birthDate.value,
              errorText: editInfoController.birthDateError.value,
              onDateSelected: editInfoController.setBirthDate,
            ),
            CustomeTextField(
              dataName: "user name",
              prefixIcon: Icons.abc,
              textEditingController: editInfoController.userNameController,
              errorText: editInfoController.userNameError.value,
            ),
            SaveChangesButton(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
