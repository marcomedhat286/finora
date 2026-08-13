import 'package:finora/domain/entities/user.dart';
import 'package:finora/presentation/edit_profile/widgets/edit_user_profile.dart';
import 'package:finora/presentation/sign_up/widgets/custome_text_field.dart';
import 'package:flutter/material.dart';

class EditUserInfoBody extends StatelessWidget {
  const EditUserInfoBody({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          EditProfileImage(user: user),
          CustomeTextField(
            dataName: "first Name",
            hinitMessage: user.firstName.value,
            prefixIcon: Icons.abc,
            textEditingController: TextEditingController(),
            errorText: "",
          ),
        ],
      ),
    );
  }
}
