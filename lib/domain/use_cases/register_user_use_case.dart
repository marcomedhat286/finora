import 'package:finora/domain/entities/user.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/value_object/user_name.dart';
import 'package:finora/domain/services/account_id_generator.dart';
import 'package:finora/domain/services/user_name_generator.dart';
import 'package:finora/domain/repositories/user_repository.dart';

class RegisterUserUseCase {
  final UserRepository _userRepository;
  RegisterUserUseCase(this._userRepository);

  Future<User> excuteNewOne({
    String? user_name,
    required String firstName,
    required double initialBalance,
    String? middleName,
    String? lastName,
  }) async {
    final UserName newUserName;
    if (user_name != null) {
      newUserName = UserName.create(value: user_name);
    } else {
      newUserName = await UserNameGenerator.generateUserName(name: firstName);
    }
    final newIdAccount = AccountIDGenerator.generateAccountId();
    final initialAccount = Account.create(
      id: newIdAccount,
      initialBalance: initialBalance,
      createdAt: DateTime.now(),
    );
    final user = User.create(
      userName: newUserName,
      firstName: firstName,
      account: initialAccount,
      middleName: middleName,
      lastName: lastName,
      createdAt: DateTime.now(),
    );
    await _userRepository.saveUser(user);

    return user;
  }
}
