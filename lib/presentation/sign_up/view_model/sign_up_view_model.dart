import 'package:finora/domain/exception/empty_value_exception.dart';
import 'package:finora/domain/exception/invalid_amount_exception.dart';
import 'package:finora/domain/exception/invalid_birthdate_exception.dart';
import 'package:finora/domain/exception/invalid_converting_double.dart';
import 'package:finora/domain/exception/invalid_format_exception.dart';
import 'package:finora/domain/use_cases/register_new_user_use_case.dart';
import 'package:finora/presentation/sign_up/view_model/auth_controller.dart';
import 'package:get/get.dart';

class SignUpViewModel extends GetxController {
  final RegisterUserUseCase signUpNewUserUseCase;
  SignUpViewModel({required this.signUpNewUserUseCase});
  final birthDate = Rxn<DateTime>();
  var isLoading = false.obs;
  var firstNameError = RxnString();
  var middleNameError = RxnString();
  var lastNameError = RxnString();
  var initialBalanceError = RxnString();
  var userNameError = RxnString();
  var birthDateError = RxnString();
  Future<void> submitSignUp({
    required String firstName,
    required String initialBalance,
    required DateTime? birthDate,
    String? user_name,
    String? middleName,
    String? lastName,
  }) async {
    _resetErrors();
    isLoading.value = true;
    try {
      final newUser = await signUpNewUserUseCase.execute(
        userName: user_name,
        firstName: firstName,
        birthDate: birthDate,
        initialBalance: initialBalance,
        middleName: middleName,
        lastName: lastName,
      );
      AuthController.to.setUser(newUser);
      Get.offAllNamed('/home');
      isLoading.value = false;
    } on EmptyValueException catch (e) {
      _setErrors(e);
    } on InvalidAmountException catch (e) {
      initialBalanceError.value = e.message;
    } on InvalidConvertingDouble catch (e) {
      initialBalanceError.value = e.message;
    } on InvalidFormatException catch (e) {
      _setErrors(e);
    } on InvalidBirthdateException catch (e) {
      birthDateError.value = e.message;
    } catch (e) {
      userNameError.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void setBirthDate(DateTime date) {
    birthDate.value = date;
  }

  void _setErrors(Exception e) {
    final message = e.toString();
    if (message.contains("first")) {
      firstNameError.value = message;
    } else if (message.contains("middle")) {
      middleNameError.value = message;
    } else if (message.contains("last")) {
      lastNameError.value = message;
    } else if (message.contains("user")) {
      userNameError.value = message;
    } else if (message.contains("balance")) {
      initialBalanceError.value = message;
    } else if (message.contains("birthday")) {
      birthDateError.value = message;
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
