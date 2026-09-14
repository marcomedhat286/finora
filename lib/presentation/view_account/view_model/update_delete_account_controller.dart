import 'package:finora/core/utils/parse/money_input_parser.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/enum/account/account_type.dart';
import 'package:finora/domain/exception/account/invalid_account_name_length_exception.dart';
import 'package:finora/domain/exception/account/invalid_account_type_exception.dart';
import 'package:finora/domain/exception/account/invalid_amount_exception.dart';
import 'package:finora/domain/exception/account/invalid_double_format_exception.dart';
import 'package:finora/domain/exception/account/not_found_account_exception.dart';
import 'package:finora/domain/exception/user/empty_value_exception.dart';
import 'package:finora/domain/exception/user/invalid_format_exception.dart';
import 'package:finora/domain/usecases/account/delete_account_usecase.dart';
import 'package:finora/domain/usecases/account/update_account_usecase.dart';
import 'package:finora/domain/validators/account/account_name_validator.dart';
import 'package:finora/domain/validators/account/account_type_validator.dart';
import 'package:finora/domain/value_object/account/money.dart';
import 'package:finora/presentation/controller/auth_accounts_controller.dart';
import 'package:get/get.dart';

class UpdateDeleteAccountController extends GetxController {
  final UpdateAccountUsecase _updateAccountUsecase;
  final DeleteAccountUsecase _deleteAccountUsecase;
  UpdateDeleteAccountController({
    required this._updateAccountUsecase,
    required this._deleteAccountUsecase,
  });
  final oldAccount = Rxn<Account>();
  final accountName = RxnString();
  final accountType = Rxn<AccountType>();
  final accountInitialBalance = RxnDouble();
  final isDefault = RxnBool();

  final accountNameError = RxnString();
  final accountTypeError = RxnString();
  final accountInitialBalanceError = RxnString();

  final isLoading = false.obs;

  void initiateAttributes(Account oldOne) {
    oldAccount.value = oldOne;
    accountName.value = oldOne.name.value;
    accountType.value = oldOne.type;
    accountInitialBalance.value = oldOne.currentBalance.value;
    isDefault.value = oldOne.isDefault;
  }

  void parseAccountName(String value) {
    _resetErrors();
    try {
      final cleanedName = AccountNameValidator.validateOrThrow(value);
      accountName.value = cleanedName;
    } on Exception catch (e) {
      _handleErrors(e);
    }
  }

  void parseAccountType(String value) {
    _resetErrors();
    try {
      final cleanedType = AccountTypeValidator.validateAndParse(value);
      accountType.value = cleanedType;
    } on Exception catch (e) {
      _handleErrors(e);
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
      accountInitialBalance.value = doubleValue;
    } on Exception catch (e) {
      _handleErrors(e);
    }
  }

  Future<void> sumbitUpdate() async {
    isLoading.value = true;
    _resetErrors();

    try {
      if (oldAccount.value != null) {
        final updatedAccounts = await _updateAccountUsecase.execute(
          oldAccount: oldAccount.value!,
          rawAccountName: accountName.value,
          accountTypeCode: accountType.value?.code,
          rawInitialBalance: (accountInitialBalance.value != null)
              ? "${accountInitialBalance.value}"
              : null,
          isDefault: isDefault.value,
        );

        AuthAccountsController.to.setAccount(updatedAccounts);
        Get.back();
      }
    } on Exception catch (e) {
      _handleErrors(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sumbitDelete() async {
    isLoading.value = true;
    _resetErrors();
    try {
      if (oldAccount.value != null) {
        final updateAccounts = await _deleteAccountUsecase.execute(
          oldAccount.value!,
        );

        if (updateAccounts != null) {
          AuthAccountsController.to.setAccount(updateAccounts);
        }
        Get.back();
      }
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
      case NotFoundAccountException _:
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
  }
}
