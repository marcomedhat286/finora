import 'package:finora/domain/repositories/user_repository.dart';
import 'package:finora/domain/use_cases/update_user_info_use_case.dart';
import 'package:finora/domain/use_cases/update_username_usecase.dart';
import 'package:finora/presentation/edit_profile/view_model/view_model_change_profile.dart';
import 'package:finora/presentation/edit_profile/widgets/edit_user_info_body.dart';
import 'package:finora/presentation/sign_up/view_model/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditUserProfile extends StatelessWidget {
  const EditUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(
      EditUserInfoViewModel(
        editUserInfoUserCase: UpdateProfileInfoUseCase(
          userRepository: UserRepository(),
        ),
        updateUserName: UpdateUsernameUsecase(userRepository: UserRepository()),
      ),
    );
    return Scaffold(
      body: Obx(() {
        final user = AuthController.to.currentUser;
        if (user == null) return const SizedBox();
        return EditUserInfoBody(user: user);
      }),
    );
  }
}
