import 'package:finora/domain/repositories/user_repository.dart';
import 'package:finora/domain/use_cases/update_initial_balance_use_case.dart';
import 'package:finora/domain/use_cases/update_user_info_use_case.dart';
import 'package:finora/domain/use_cases/update_username_usecase.dart';
import 'package:finora/presentation/edit_profile/view_model/update_user_profile_view_model.dart';
import 'package:finora/presentation/edit_profile/widgets/edit_user_info_body.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditUserProfile extends StatelessWidget {
  const EditUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(
      UpdateUserProfileViewModel(
        editUserInfoUserCase: UpdateProfileInfoUseCase(
          userRepository: UserRepository(),
        ),
        updateUserName: UpdateUsernameUsecase(userRepository: UserRepository()),
        updateInitialBalance: UpdateInitialBalanceUseCase(
          userRepository: UserRepository(),
        ),
      ),
    );
    return Scaffold(body: const EditUserInfoBody());
  }
}
