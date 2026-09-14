import 'package:finora/domain/entities/account.dart';

abstract interface class AccountRepository {
  Future<void> saveAccount(Account account);
  Future<void> updateAccount(Account account);
  Future<bool> deleteAccount(String accountId);
  Future<List<Account>> getAccounts(String userId);
}
