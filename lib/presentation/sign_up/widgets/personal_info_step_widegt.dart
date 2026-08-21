import 'package:finora/presentation/sign_up/view_model/sign_up_view_model.dart';
import 'package:finora/presentation/sign_up/widgets/custome_date_picker.dart';
import 'package:finora/presentation/sign_up/widgets/custome_text_field.dart';
import 'package:finora/presentation/sign_up/widgets/next_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalInfoStepWidegt extends StatelessWidget {
  const PersonalInfoStepWidegt({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignUpViewModel>();
    return Obx(
      () => Column(
        children: [
          Text(
            "Enter u personal Inforamtion",
            style: CustomeTextField.textStyleDataName,
          ),
          const SizedBox(height: 20),
          CustomeTextField(
            dataName: "first name",
            hinitMessage: "EG. Marco",
            prefixIcon: Icons.abc_outlined,
            textEditingController: controller.firstNameController,
            errorText: controller.firstNameError.value,
          ),
          CustomeTextField(
            dataName: "middle name",
            hinitMessage: "EG. Medhat",
            prefixIcon: Icons.abc_outlined,
            textEditingController: controller.middleNameController,
            errorText: controller.middleNameError.value,
          ),
          CustomeTextField(
            dataName: "last name",
            hinitMessage: "EG. Moner",
            prefixIcon: Icons.abc_outlined,
            textEditingController: controller.lastNameController,
            errorText: controller.lastNameError.value,
          ),
          CustomeDatePickerField(
            dataName: "birthday",
            errorText: controller.birthDateError.value,
            onDateSelected: controller.setBirthDate,
            initialDate: controller.birthDate.value,
          ),
          const NextButton(),
        ],
      ),
    );
  }
}
