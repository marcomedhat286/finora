import 'package:finora/data/mapper/account_mapper.dart';
import 'package:finora/data/models/account_model.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/exception/account/not_found_account_exception.dart';
import 'package:finora/domain/repositories/account_repository.dart';
import 'package:isar_community/isar.dart';

class IsarAccountRepository implements AccountRepository {
  final Isar _isar;
  IsarAccountRepository(this._isar);
  @override
  Future<void> deleteAccount(String accountId) {
    throw UnimplementedError();
  }

  @override
  Future<List<Account>> getAccounts(String userId) async {
    final accountsModel = await _isar.accountModels
        .filter()
        .userIdEqualTo(userId)
        .findAll();

    return accountsModel
        .map((accountModel) => AccountMapper.toEntity(accountModel))
        .toList();
  }

  @override
  Future<void> saveAccount(Account account) async {
    final accountModel = AccountMapper.toModel(account);
    await _isar.writeTxn(() async {
      await _isar.accountModels.put(accountModel);
    });
  }

  @override
  Future<void> updateAccount(Account account) async {
    await _isar.writeTxn(() async {
      final existingAccount = await _isar.accountModels
          .filter()
          .accountIdEqualTo(account.id.value)
          .findFirst();

      if (existingAccount == null) {
        throw NotFoundAccountException(
          'this account not identical with new one',
        );
      }

      final accountModel = AccountMapper.toModel(account);

      accountModel.isarId = existingAccount.isarId;
      await _isar.accountModels.put(accountModel);
    });
  }
}
