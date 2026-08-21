import 'package:finora/domain/entities/account.dart';

abstract interface class AccountRepository {
  factory AccountRepository() => FakeAccountRepository();
  Future<void> saveAccount(Account account);
  Future<void> updateAccount(Account account);
  Future<void> deleteAccount(String accountId);
  Future<Account?> getAccount(String accountId);
}

class FakeAccountRepository implements AccountRepository {
  @override
  Future<void> saveAccount(Account account) async {
    await Future.delayed(Duration(seconds: 4));
    print("the new account has been saved : ${account.id}");
  }

  @override
  Future<void> updateAccount(Account account) async {
    await Future.delayed(Duration(seconds: 4));
    print("the ${account.id} account has been updated");
  }

  @override
  Future<Account?> getAccount(String accountId) async {
    await Future.delayed(Duration(seconds: 4));
    print("will get the account id $accountId");
  }

  @override
  Future<void> deleteAccount(String accountId) async {
    await Future.delayed(Duration(seconds: 4));
    print("will delete the account id $accountId");
  }
}
