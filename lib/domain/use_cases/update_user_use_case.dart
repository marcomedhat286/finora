import 'package:finora/domain/entities/user.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/value_object/user_name.dart';
import 'package:finora/domain/repositories/user_repository.dart';

class UpdateUserUseCase {
  final UserRepository _userRepository;
  UpdateUserUseCase(this._userRepository);

  Future<User> excute({
    required User oldUser,
    String? userName,
    String? firstName,
    Object? middleName = User.sentinel,
    Object? lastName = User.sentinel,
    double? initialBalance,
    double? currentBalance,
  }) async {
    UserName? newUsername;

    Account? newAccount;
    if (userName != null) {
      newUsername = UserName.create(value: userName);
    }
    if (initialBalance != null || currentBalance != null) {
      newAccount = oldUser.account.copyWith(
        newInitialBalance: initialBalance,
        newCurrentBalance: currentBalance,
      );
    }

    final updatedUser = oldUser.copyWith(
      userName: newUsername,
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      account: newAccount,
    );
    await _userRepository.updateUser(updatedUser);

    return updatedUser;
  }
}
