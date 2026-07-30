import 'package:finora/domain/exception/empty_value_exception.dart';
import 'package:finora/domain/exception/invalid_amount_exception.dart';
import 'package:finora/domain/exception/invalid_converting_double.dart';
import 'package:finora/domain/exception/invalid_format_exception.dart';
import 'package:finora/domain/use_cases/register_user_use_case.dart';
import 'package:get/get.dart';

class SignUpViewModel extends GetxController {
  final RegisterUserUseCase signUpUserUseCase;
  SignUpViewModel({required this.signUpUserUseCase});
  var isLoading = false.obs;
  var firstNameError = RxnString();
  var middleNameError = RxnString();
  var lastNameError = RxnString();
  var initialBalanceError = RxnString();
  var userNameError = RxnString();
  Future<void> submitSignUp({
    required String firstName,
    required String initialBalance,
    String? user_name,
    String? middleName,
    String? lastName,
  }) async {
    _resetErrors();
    isLoading.value = true;
    try {
      final user = await signUpUserUseCase.excuteNewOne(
        user_name: user_name,
        firstName: firstName,
        initialBalance: initialBalance,
        middleName: middleName,
        lastName: lastName,
      );
      print(user);
      isLoading.value = false;
    } on EmptyValueException catch (e) {
      setErrors(e);
    } on InvalidAmountException catch (e) {
      initialBalanceError.value = e.message;
    } on InvalidConvertingDouble catch (e) {
      initialBalanceError.value = e.message;
    } on InvalidFormatException catch (e) {
      setErrors(e);
    } catch (e) {
      print(e);
      print("catch");
    } finally {
      isLoading.value = false;
    }
  }

  void setErrors(Exception e) {
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
    }
  }

  void _resetErrors() {
    firstNameError.value = null;
    middleNameError.value = null;
    lastNameError.value = null;
    userNameError.value = null;
    initialBalanceError.value = null;
  }
}
