import 'package:finora/core/constants.dart';
import 'package:finora/domain/repositories/user_repository.dart';
import 'package:finora/domain/use_cases/register_user_use_case.dart';
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
    final SignUpViewModel controller = Get.put(
      SignUpViewModel(
        signUpUserUseCase: RegisterUserUseCase(
          userRepository: UserRepository(),
        ),
      ),
    );

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
          child: Obx(
            () => Column(
              children: [
                CustomeTextField(
                  dataName: "first name",
                  hinitMessage: "eg. marco",
                  prefixIcon: Icons.abc_outlined,
                  textEditingController: firstName,
                  errorText: controller.firstNameError.value,
                ),
                CustomeTextField(
                  dataName: "middle name",
                  hinitMessage: "eg. medhat",
                  prefixIcon: Icons.abc_outlined,
                  textEditingController: middleName,
                  errorText: controller.middleNameError.value,
                ),
                CustomeTextField(
                  dataName: "last name",
                  hinitMessage: "eg. moner",
                  prefixIcon: Icons.abc_outlined,
                  textEditingController: lastName,
                  errorText: controller.lastNameError.value,
                ),
                DatePickerField(
                  dataName: "birthday",
                  errorText: controller.birthDateError.value,
                  onDateSelected: controller.setBirthDate,
                ),
                CustomeTextField(
                  dataName: "initial balance",
                  hinitMessage: "eg. 20",
                  prefixIcon: Icons.attach_money_outlined,
                  textEditingController: balance,
                  errorText: controller.initialBalanceError.value,
                ),
                CustomeTextField(
                  dataName: "user name",
                  hinitMessage:
                      "eg. marco_1234 or Sign up and we will generate new one for u.",
                  prefixIcon: Icons.verified_user,
                  textEditingController: userName,
                  errorText: controller.userNameError.value,
                ),
                SignUpButton(
                  firstName: firstName,
                  lastName: lastName,
                  middleName: middleName,
                  userName: userName,
                  balance: balance,
                  birthDate: controller.birthDate.value,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
