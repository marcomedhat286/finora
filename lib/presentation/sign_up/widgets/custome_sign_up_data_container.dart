import 'package:finora/core/constants.dart';
import 'package:finora/presentation/sign_up/view_model/sign_up_view_model.dart';
import 'package:finora/presentation/sign_up/widgets/custome_date_picker.dart';
import 'package:finora/presentation/sign_up/widgets/custome_text_field.dart';
import 'package:finora/presentation/sign_up/widgets/sign_up_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomeSignUpDataContainer extends StatelessWidget {
  const CustomeSignUpDataContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final firstName = TextEditingController();
    final middleName = TextEditingController();
    final lastName = TextEditingController();
    final userName = TextEditingController();
    final balance = TextEditingController();

    return Align(
      alignment: AlignmentGeometry.bottomCenter,
      child: Container(
        height: 625,
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: const BoxDecoration(
          color: kSecondColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: blurRadius,
              spreadRadius: 5,
              offset: Offset(0, 15),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Obx(() {
            final signUpController = Get.find<SignUpViewModel>();
            return Column(
              children: [
                CustomeTextField(
                  dataName: "first name",
                  hinitMessage: "EG. Marco",
                  prefixIcon: Icons.abc_outlined,
                  textEditingController: firstName,
                  errorText: signUpController.firstNameError.value,
                ),
                CustomeTextField(
                  dataName: "middle name",
                  hinitMessage: "EG. Medhat",
                  prefixIcon: Icons.abc_outlined,
                  textEditingController: middleName,
                  errorText: signUpController.middleNameError.value,
                ),
                CustomeTextField(
                  dataName: "last name",
                  hinitMessage: "EG. Moner",
                  prefixIcon: Icons.abc_outlined,
                  textEditingController: lastName,
                  errorText: signUpController.lastNameError.value,
                ),
                CustomeDatePickerField(
                  dataName: "birthday",
                  errorText: signUpController.birthDateError.value,
                  onDateSelected: signUpController.setBirthDate,
                ),
                CustomeTextField(
                  dataName: "initial balance",
                  hinitMessage: "EG. 1000",
                  prefixIcon: Icons.attach_money_outlined,
                  textEditingController: balance,
                  errorText: signUpController.initialBalanceError.value,
                ),
                CustomeTextField(
                  dataName: "user name",
                  hinitMessage:
                      "EG. marco_1234 or Sign up and we will generate new one for u.",
                  prefixIcon: Icons.verified_user,
                  textEditingController: userName,
                  errorText: signUpController.userNameError.value,
                ),
                SignUpButton(
                  firstName: firstName,
                  lastName: lastName,
                  middleName: middleName,
                  userName: userName,
                  balance: balance,
                  birthDate: signUpController.birthDate.value,
                ),
                const SizedBox(height: 30),
              ],
            );
          }),
        ),
      ),
    );
  }
}
