import 'package:finora/core/utils/parse/money_input_parser.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/enum/account_type.dart';
import 'package:finora/domain/exception/empty_value_exception.dart';
import 'package:finora/domain/exception/invalid_account_name_length_exception.dart';
import 'package:finora/domain/exception/invalid_account_type_exception.dart';
import 'package:finora/domain/exception/invalid_amount_exception.dart';
import 'package:finora/domain/exception/invalid_birthdate_exception.dart';
import 'package:finora/domain/usecases/account/create_account_usecase.dart';
import 'package:finora/domain/usecases/user/create_user_usecase.dart';
import 'package:finora/domain/validators/account_name_validator.dart';
import 'package:finora/domain/validators/account_type_validator.dart';
import 'package:finora/domain/validators/birthdate_validator.dart';
import 'package:finora/domain/exception/invalid_format_exception.dart';
import 'package:finora/domain/validators/invalid_double_format_exception.dart';
import 'package:finora/domain/validators/money_validator.dart';
import 'package:finora/domain/validators/name_validator.dart';
import 'package:finora/presentation/sign_up/view_model/auth_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpViewModel extends GetxController {
  final CreateUserUseCase createNewUser;
  final CreateAccountUseCase createAccountUseCase;
  SignUpViewModel({
    required this.createNewUser,
    required this.createAccountUseCase,
  });

  // Form controllers
  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final birthDate = Rxn<DateTime>();
  final accountNameController = TextEditingController();
  final initialBalanceController = TextEditingController();
  final accountType = Rxn<AccountType>(AccountType.cash);
  final userNameController = TextEditingController();

  // Errors
  var firstNameError = RxnString();
  var middleNameError = RxnString();
  var lastNameError = RxnString();
  var birthDateError = RxnString();
  var accountNameError = RxnString();
  var accountTypeError = RxnString();
  var initialBalanceError = RxnString();
  var userNameError = RxnString();

  // state
  final currentStep = 0.obs;
  var isLoading = false.obs;
  var _setDefaultAccount = false;

  void perviousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void nextStep() {
    _resetErrors();
    try {
      _validateCurrentStep();
      currentStep.value++;
    } on EmptyValueException catch (e) {
      _setErrors(e);
    } on InvalidFormatException catch (e) {
      _setErrors(e);
    } on InvalidBirthdateException catch (e) {
      birthDateError.value = e.message;
    } on InvalidAccountNameLengthException catch (e) {
      accountNameError.value = e.message;
    } on InvalidAccountTypeException catch (e) {
      accountTypeError.value = e.message;
    } on InvalidDoubleFormatException catch (e) {
      initialBalanceError.value = e.message;
    } on InvalidAmountException catch (e) {
      initialBalanceError.value = e.message;
    }
  }

  void skipAccountStep() {
    currentStep.value++;
    _setDefaultAccount = true;
  }

  void _validateCurrentStep() {
    switch (currentStep.value) {
      case 0:
        NameValidator.validateOrThrow(
          nameType: "first name",
          name: firstNameController.text,
        );

        (middleNameController.text.isNotEmpty)
            ? NameValidator.validateOrThrow(
                nameType: "middle name",
                name: middleNameController.text,
              )
            : null;

        (lastNameController.text.isNotEmpty)
            ? NameValidator.validateOrThrow(
                nameType: "last name",
                name: lastNameController.text,
              )
            : null;

        BirthdateValidator.validateOrThrow(birthDate.value);
        break;

      case 1:
        AccountNameValidator.validateOrThrow(accountNameController.text);
        AccountTypeValidator.validateAndParse(accountType.value?.code);

        final doubleValue = MoneyInputParser.parseToDouble(
          fieldName: "initial Balance",
          value: initialBalanceController.text,
        );
        MoneyValidator.validateOrThrow(
          amount: doubleValue,
          inclusiveZero: true,
        );
        break;
    }
  }

  Future<void> submitSignUp() async {
    _resetErrors();
    isLoading.value = true;
    try {
      final newUser = await createNewUser.execute(
        userName: (userNameController.text.isNotEmpty)
            ? userNameController.text
            : null,
        firstName: firstNameController.text,
        middleName: (middleNameController.text.isNotEmpty)
            ? middleNameController.text
            : null,
        lastName: (lastNameController.text.isNotEmpty)
            ? lastNameController.text
            : null,
        birthDate: birthDate.value,
      );
      final Account newAccount;
      if (!_setDefaultAccount) {
        newAccount = await createAccountUseCase.execute(
          rawUserId: newUser.id.value,
          rawAccountName: accountNameController.text,
          accountTypeCode: accountType.value!.code,
          rawInitialBalance: initialBalanceController.text,
        );
      } else {
        newAccount = await createAccountUseCase.createDefaultCashAccount(
          rawUserId: newUser.id.value,
        );
      }

      AuthUserController.to.setUser(newUser);
      AuthUserController.to.setAccount(newAccount);
      Get.offAllNamed('/home');
      isLoading.value = false;
    } on EmptyValueException catch (e) {
      _setErrors(e);
    } on InvalidFormatException catch (e) {
      _setErrors(e);
    } on InvalidBirthdateException catch (e) {
      birthDateError.value = e.message;
    } on InvalidAccountNameLengthException catch (e) {
      accountNameError.value = e.message;
    } on InvalidAccountTypeException catch (e) {
      accountTypeError.value = e.message;
    } on InvalidDoubleFormatException catch (e) {
      initialBalanceError.value = e.message;
    } on InvalidAmountException catch (e) {
      initialBalanceError.value = e.message;
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
    } else if (message.contains("birthday")) {
      birthDateError.value = message;
    } else if (message.contains("account name")) {
      accountNameError.value = message;
    } else if (message.contains("account type")) {
      accountTypeError.value = message;
    } else if (message.contains("initial Balance")) {
      initialBalanceError.value = message;
    } else if (message.contains("username")) {
      userNameError.value = message;
    }
  }

  void _resetErrors() {
    firstNameError.value = null;
    middleNameError.value = null;
    lastNameError.value = null;
    birthDateError.value = null;
    accountNameError.value = null;
    accountTypeError.value = null;
    initialBalanceError.value = null;
    userNameError.value = null;
  }

  @override
  void onClose() {
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    accountNameController.dispose();
    initialBalanceController.dispose();
    userNameController.dispose();

    super.onClose();
  }
}
