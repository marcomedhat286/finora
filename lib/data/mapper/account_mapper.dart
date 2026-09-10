import 'package:finora/data/models/account_model.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/enum/account/account_type.dart';
import 'package:finora/domain/value_object/account/account_id.dart';
import 'package:finora/domain/value_object/account/account_name.dart';
import 'package:finora/domain/value_object/account/money.dart';
import 'package:finora/domain/value_object/user/user_id.dart';

class AccountMapper {
  static AccountModel toModel(Account account) {
    return AccountModel()
      ..accountId = account.id.value
      ..userId = account.userId.value
      ..accountName = account.name.value
      ..accountType = account.type.code
      ..initialBalance = account.initialBalance.value
      ..currentBalance = account.currentBalance.value
      ..createdAt = account.createdAt
      ..hasTransactions = account.hasTransactions
      ..isDefault = account.isDefault;
  }

  static Account toEntity(AccountModel model) {
    return Account.create(
      id: AccountId.fromUniqueString(model.accountId),
      userId: UserId.create(model.userId),
      accountName: AccountName.create(model.accountName),
      accountType: AccountType.fromCode(model.accountType),
      initialBalance: Money.create(value: model.initialBalance),
      currentBalance: Money.create(value: model.currentBalance),
      hasTransactions: model.hasTransactions,
      createdAt: model.createdAt,
      isDefault: model.isDefault,
    );
  }
}
