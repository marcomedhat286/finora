import 'package:finora/core/utils/parse/money_input_parser.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/enum/account_type.dart';
import 'package:finora/domain/repositories/account_repository.dart';
import 'package:finora/domain/services/account_id_generator.dart';

import 'package:finora/domain/value_object/account_name.dart';
import 'package:finora/domain/value_object/money.dart';
import 'package:finora/domain/value_object/user_id.dart';

class CreateAccountUseCase {
  final AccountRepository _accountRepository;

  CreateAccountUseCase({required this._accountRepository});

  Future<Account> execute({
    required String rawUserId,
    required String rawAccountName,
    required String accountTypeCode,
    required String rawInitialBalance,
  }) async {
    // 1. تحويل الـ Raw Data إلى Value Objects وحث الـ Validations
    final userId = UserId.create(rawUserId);
    final accountId = AccountIdGenerator.generateAccountId();
    final accountName = AccountName.create(rawAccountName);
    final doubleValue = MoneyInputParser.parseToDouble(
      value: rawInitialBalance,
      fieldName: "initialBalance",
    );
    final initialBalance = Money.create(
      value: doubleValue,
      inclusiveZero: true,
    );

    final accountType = AccountType.fromCode(accountTypeCode);

    final account = Account.create(
      id: accountId,
      userId: userId,
      accountName: accountName,
      accountType: accountType,
      initialBalance: initialBalance,
      createdAt: DateTime.now(),
    );

    // 4. الحفظ في الـ Repository
    await _accountRepository.saveAccount(account);

    return account;
  }

  Future<Account> createDefaultCashAccount({required String rawUserId}) async {
    return execute(
      rawUserId: rawUserId,
      rawAccountName: 'cash wallet',
      accountTypeCode: AccountType.cash.code,
      rawInitialBalance: "0.0",
    );
  }
}
