import 'package:finora/domain/entities/user.dart';
import 'package:finora/domain/repositories/user_repository.dart';

import 'package:finora/domain/use_cases/register_user_use_case.dart';
import 'package:finora/domain/use_cases/update_user_use_case.dart';

class FakeUserRepository implements UserRepository {
  @override
  Future<void> saveUser(User user) async {
    print("the new user has been saved : ${user.userName}");
  }

  @override
  Future<void> updateUser(User user) async {
    print("the  user has been updated");
  }

  @override
  Future<bool> isUsernameTaken(String username) async {
    return username == "marco_123";
  }
}

void main() async {
  try {
    final userRepository = UserRepository();
    final registerUserUseCase = RegisterUserUseCase(userRepository);

    final user = await registerUserUseCase.excuteNewOne(
      user_name: "mDrco_12",
      firstName: "mariam",

      lastName: "moner",
      initialBalance: 2000,
    );
    print(user);
    print("-" * 100);
    final newUser = user.copyWith(
      account: user.account.copyWith(newCurrentBalance: 199),
    );
    print(newUser);
    print("-" * 100);
    final updateUserUseCase = UpdateUserUseCase(userRepository);
    final modUser = await updateUserUseCase.excute(
      oldUser: newUser,

      firstName: "medhat",
      middleName: null,
      lastName: null,
      initialBalance: 0,
    );

    print(modUser);
    // print("-" * 100);
    // final copyUser = User.fromJson(json: modUser.toMap());
    // print(copyUser);
    // print(copyUser == modUser);
    // print("-" * 100);
  } catch (e) {
    print(e);
  }
}
