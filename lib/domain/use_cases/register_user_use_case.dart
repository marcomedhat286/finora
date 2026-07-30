import 'package:finora/domain/entities/user.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/repositories/user_repository.dart';
import 'package:finora/domain/services/convert_string_todouble_balance.dart';
import 'package:finora/domain/value_object/user_name.dart';
import 'package:finora/domain/services/account_id_generator.dart';
import 'package:finora/domain/services/user_name_generator.dart';

class RegisterUserUseCase {
  final UserRepository _userRepository;
  const RegisterUserUseCase({required this._userRepository});

  Future<User> excuteNewOne({
    String? user_name,
    required String firstName,
    required String initialBalance,
    String? middleName,
    String? lastName,
  }) async {
    final now = DateTime.now();
    final newUserName = _getNewUserName(user_name, firstName);
    Account initialAccount = _getNewAccount(
      initialBalance: initialBalance,
      createdAt: now,
    );

    final user = User.create(
      userName: newUserName,
      firstName: firstName,
      account: initialAccount,
      middleName: middleName,
      lastName: lastName,
      createdAt: now,
    );
    await _userRepository.saveUser(user);

    return user;
  }

  Account _getNewAccount({
    required String initialBalance,
    required DateTime createdAt,
  }) {
    final newIdAccount = AccountIDGenerator.generateAccountId();
    final initialBalanceDouble = ConvertStringTodoubleBalance.convert(
      value: initialBalance,
      valueName: "initial balance",
    );

    final initialAccount = Account.create(
      id: newIdAccount,
      initialBalance: initialBalanceDouble,
      createdAt: createdAt,
    );
    return initialAccount;
  }

  UserName _getNewUserName(String? user_name, String firstName) {
    if (user_name != null) {
      return UserName.create(value: user_name);
    } else {
      return UserNameGenerator.generateUserName(name: firstName);
    }
  }
}
