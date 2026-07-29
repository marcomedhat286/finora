import 'package:finora/core/constants.dart';
import 'package:finora/presentation/sign_up/widgets/custome_text_field.dart';
import 'package:flutter/material.dart';

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
          child: Column(
            children: [
              CustomeTextField(
                dataName: "first name",
                hinitMessage: "marco",
                prefixIcon: Icons.abc_outlined,
                textEditingController: firstName,
              ),
              CustomeTextField(
                dataName: "middle name",
                hinitMessage: "medhat",
                prefixIcon: Icons.abc_outlined,
                textEditingController: middleName,
              ),
              CustomeTextField(
                dataName: "last name",
                hinitMessage: "moner",
                prefixIcon: Icons.abc_outlined,
                textEditingController: lastName,
              ),
              CustomeTextField(
                dataName: "initial balance",
                hinitMessage: "20",
                prefixIcon: Icons.attach_money_outlined,
                textEditingController: balance,
              ),
              CustomeTextField(
                dataName: "user name",
                hinitMessage: "marco_1234",
                prefixIcon: Icons.verified_user,
                textEditingController: userName,
              ),

              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 30),
                child: ElevatedButton(
                  onPressed: () {
                    final map = {
                      "firstName": firstName.text,
                      "lastName": lastName.text,
                      "middleName": middleName.text,
                      "userName": userName.text,
                      "balance": balance.text,
                    };
                    print(map);
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: kPrimaryColor,
                          blurRadius: blurRadius,
                          spreadRadius: 8,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    // width: screenWidth - 100,
                    child: const Text(
                      "Sign",
                      style: TextStyle(color: kSecondColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
