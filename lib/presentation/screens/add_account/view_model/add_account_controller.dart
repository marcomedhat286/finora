import 'package:finora/core/utils/parse/money_input_parser.dart';
import 'package:finora/domain/entities/user.dart';
import 'package:finora/domain/enum/account/account_type.dart';
import 'package:finora/domain/exception/account/invalid_account_name_length_exception.dart';
import 'package:finora/domain/exception/account/invalid_account_type_exception.dart';
import 'package:finora/domain/exception/account/invalid_amount_exception.dart';
import 'package:finora/domain/exception/account/invalid_double_format_exception.dart';
import 'package:finora/domain/exception/user/empty_value_exception.dart';
import 'package:finora/domain/exception/user/invalid_format_exception.dart';
import 'package:finora/domain/usecases/account/create_account_usecase.dart';
import 'package:finora/domain/validators/account/account_name_validator.dart';
import 'package:finora/domain/validators/account/account_type_validator.dart';
import 'package:finora/domain/value_object/account/money.dart';
import 'package:finora/presentation/controller/auth_accounts_controller.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

class AddAccountController extends GetxController {
  final CreateAccountUseCase createAccount;
  AddAccountController({required this.createAccount});
  final accountName = RxnString();
  final accountType = Rx<AccountType>(AccountType.cash);
  final accountInitialBalance = RxnString();
  final accountCreatedAt = Rx<DateTime>(DateTime.now());
  final isDefault = false.obs;

  final accountNameError = RxnString();
  final accountTypeError = RxnString();
  final accountInitialBalanceError = RxnString();
  final otherError = RxnString();

  final isLoading = false.obs;
  void parseAccountName(String value) {
    _resetErrors();
    try {
      final cleanedName = AccountNameValidator.validateOrThrow(value);
      accountName.value = cleanedName;
    } on EmptyValueException catch (e) {
      accountNameError.value = e.message;
    } on InvalidAccountNameLengthException catch (e) {
      accountNameError.value = e.message;
    }
  }

  void parseAccountType(String value) {
    _resetErrors();
    try {
      final cleanedType = AccountTypeValidator.validateAndParse(value);
      accountType.value = cleanedType;
    } on EmptyValueException catch (e) {
      accountNameError.value = e.message;
    } on InvalidAccountTypeException catch (e) {
      accountNameError.value = e.message;
    }
  }

  void parseAccountInitialBalance(String value) {
    _resetErrors();
    try {
      final doubleValue = MoneyInputParser.parseToDouble(
        value: value,
        fieldName: "initial balance",
      );
      Money.create(value: doubleValue);
      accountInitialBalance.value = value;
    } on InvalidDoubleFormatException catch (e) {
      accountInitialBalanceError.value = e.message;
    } on EmptyValueException catch (e) {
      accountInitialBalanceError.value = e.message;
    }
  }

  Future<void> sumbitCreateNewAccount(User user) async {
    isLoading.value = true;
    _resetErrors();
    try {
      final newAccount = await createAccount.execute(
        rawUserId: user.id.value,
        rawAccountName: accountName.value ?? "",
        accountTypeCode: accountType.value.code,
        rawInitialBalance: accountInitialBalance.value ?? "",
        isDefault: isDefault.value,
      );

      if (isDefault.value) {
        AuthAccountsController.to.setNewDefaultAccount(newAccount);
      } else {
        AuthAccountsController.to.addAccount(newAccount);
      }
      Get.back();
    } on Exception catch (e) {
      _handleErrors(e);
    } finally {
      isLoading.value = false;
    }
  }

  void _handleErrors(Exception e) {
    switch (e) {
      case EmptyValueException _:
        _setErrors(e);
        break;

      case InvalidFormatException _:
        _setErrors(e);
        break;

      case InvalidAccountNameLengthException _:
        accountNameError.value = e.message;
        break;

      case InvalidAccountTypeException _:
        accountTypeError.value = e.message;
        break;

      case InvalidDoubleFormatException _:
        accountInitialBalanceError.value = e.message;
        break;

      case InvalidAmountException _:
        accountInitialBalanceError.value = e.message;
        break;
    }
  }

  void _setErrors(Exception e) {
    final message = e.toString();
    if (message.contains("account name")) {
      accountNameError.value = message;
    } else if (message.contains("account type")) {
      accountTypeError.value = message;
    } else if (message.contains("initial Balance")) {
      accountInitialBalanceError.value = message;
    }
  }

  void _resetErrors() {
    accountNameError.value = null;
    accountTypeError.value = null;
    accountInitialBalanceError.value = null;
    otherError.value = null;
  }
}
