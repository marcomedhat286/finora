import 'package:finora/core/utils/parse/money_input_parser.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/enum/account/account_type.dart';
import 'package:finora/domain/repositories/account_repository.dart';
import 'package:finora/domain/value_object/account/account_name.dart';
import 'package:finora/domain/value_object/account/money.dart';
import 'package:finora/presentation/controller/auth_accounts_controller.dart';

class UpdateAccountUsecase {
  final AccountRepository _accountRepository;

  UpdateAccountUsecase({required this._accountRepository});

  Future<List<Account>> execute({
    required Account oldAccount,
    String? rawAccountName,
    String? accountTypeCode,
    String? rawInitialBalance,
    bool? isDefault,
  }) async {
    Account? newAccount;
    AccountName? newAccountName;
    AccountType? newAccountType;
    Money? newInitialBalance;

    if (rawAccountName != null &&
        rawAccountName.trim().toLowerCase() !=
            oldAccount.name.value.toLowerCase()) {
      print("flag1");
      newAccountName = AccountName.create(rawAccountName);
    }
    if (accountTypeCode != null &&
        accountTypeCode.trim().toLowerCase() !=
            oldAccount.type.code.toLowerCase()) {
      print("flag2");
      newAccountType = AccountType.fromCode(accountTypeCode);
    }

    if (rawInitialBalance != null &&
        rawInitialBalance != "${oldAccount.currentBalance.value}") {
      print("flag3");
      final doubleValue = MoneyInputParser.parseToDouble(
        value: rawInitialBalance,
        fieldName: 'initial Balance',
      );
      newInitialBalance = Money.create(value: doubleValue, inclusiveZero: true);
    }

    if (newAccountName != null ||
        newAccountType != null ||
        newInitialBalance != null ||
        (isDefault != null && isDefault != oldAccount.isDefault)) {
      print("flag4");
      newAccount = oldAccount.copyWith(
        newAccountName: newAccountName,
        newAccountType: newAccountType,
        newIsDefault: isDefault,
      );
      if (newInitialBalance != null) {
        newAccount = newAccount.updateInitialBalance(newInitialBalance);
      }
      await _accountRepository.updateAccount(newAccount);
    }

    if (isDefault == true && oldAccount.isDefault != isDefault) {
      final oldDefualtAccount = AuthAccountsController.to.defaultAccount;
      if (oldDefualtAccount != null) {
        await _accountRepository.updateAccount(
          oldDefualtAccount.copyWith(newIsDefault: false),
        );
      }
    }
    return await _accountRepository.getAccounts(oldAccount.userId.value);
  }
}
