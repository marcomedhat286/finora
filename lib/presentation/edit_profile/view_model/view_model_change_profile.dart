import 'package:finora/domain/entities/user.dart';
import 'package:finora/domain/exception/empty_value_exception.dart';

import 'package:finora/domain/exception/invalid_birthdate_exception.dart';

import 'package:finora/domain/exception/invalid_format_exception.dart';
import 'package:finora/domain/exception/invalid_image_path_exception.dart';
import 'package:finora/domain/exception/taken_user_name_exception.dart';
import 'package:finora/domain/use_cases/update_user_info_use_case.dart';
import 'package:finora/domain/use_cases/update_username_usecase.dart';
import 'package:finora/presentation/sign_up/view_model/auth_controller.dart';
import 'package:get/get.dart';

class EditUserInfoViewModel extends GetxController {
  final UpdateProfileInfoUseCase editUserInfoUserCase;
  final UpdateUsernameUsecase updateUserName;
  EditUserInfoViewModel({
    required this.editUserInfoUserCase,
    required this.updateUserName,
  });
  final birthDate = Rxn<DateTime>();
  var isLoading = false.obs;

  var firstNameError = RxnString();
  var middleNameError = RxnString();
  var lastNameError = RxnString();
  var initialBalanceError = RxnString();
  var userNameError = RxnString();
  var birthDateError = RxnString();
  var profileImagePathError = RxnString();

  Future<void> submitUpdatedInfo({
    String? firstName,
    DateTime? birthDate,
    Object? imageProfilePath = User.sentinel,
    Object? middleName = User.sentinel,
    Object? lastName = User.sentinel,
  }) async {
    _resetErrors();
    isLoading.value = true;
    final oldUser = AuthController.to.currentUser;
    if (oldUser == null) return;
    try {
      final newUser = await editUserInfoUserCase.updateUserInfo(
        oldUser: oldUser,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        birthdayDate: birthDate,
        imageProfilePath: imageProfilePath,
      );
      AuthController.to.setUser(newUser);
    } on EmptyValueException catch (e) {
      _setErrors(e);
    } on InvalidFormatException catch (e) {
      _setErrors(e);
    } on InvalidBirthdateException catch (e) {
      birthDateError.value = e.message;
    } on InvalidProfileImageException catch (e) {
      profileImagePathError.value = e.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sumbitChangeUserName({required String newUserName}) async {
    _resetErrors();
    isLoading.value = true;
    final oldUser = AuthController.to.currentUser;
    if (oldUser == null) return;

    try {
      final newuser = await updateUserName.changeUserUsername(
        user: oldUser,
        userName: newUserName,
      );
      AuthController.to.setUser(newuser);
    } on EmptyValueException catch (e) {
      userNameError.value = e.message;
    } on InvalidFormatException catch (e) {
      userNameError.value = e.message;
    } on TakenUserNameException catch (e) {
      userNameError.value = e.message;
    } finally {
      isLoading.value = false;
    }
  }

  void _setErrors(Exception e) {
    final message = e.toString();
    if (message.contains("first")) {
      firstNameError.value = message;
    } else if (message.contains("middle")) {
      middleNameError.value = message;
    } else if (message.contains("last")) {
      lastNameError.value = message;
    } else if (message.contains("birthday")) {
      birthDateError.value = message;
    } else if (message.contains("path")) {
      profileImagePathError.value = message;
    }
  }

  void _resetErrors() {
    firstNameError.value = null;
    middleNameError.value = null;
    lastNameError.value = null;
    userNameError.value = null;
    initialBalanceError.value = null;
    birthDateError.value = null;
  }
}
