import 'package:finora/domain/entities/user.dart';
import 'package:finora/domain/repositories/user_repository.dart';

class UpdateInitialBalanceUseCase {
  final UserRepository _userRepository;
  const UpdateInitialBalanceUseCase({required this._userRepository});

  Future<User> updateInitialBalance({
    required User oldUser,
    required double initialBalance,
  }) async {
    final updatedUser = oldUser.copyWith(
      account: oldUser.account.updateInitialBalance(initialBalance),
    );

    await _userRepository.updateUser(updatedUser);

    return updatedUser;
  }
}
