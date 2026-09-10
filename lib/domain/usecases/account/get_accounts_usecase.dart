import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/repositories/account_repository.dart';

import 'package:finora/domain/validators/user/user_id_validate.dart';

class GetAccountsUsecase {
  final AccountRepository _accountRepository;
  GetAccountsUsecase(this._accountRepository);
  Future<List<Account>> execute(String userId) async {
    UserIdValidate.validateOrThrow(userId);
    return await _accountRepository.getAccounts(userId);
  }
}
