import 'package:finora/domain/entities/user.dart';
import 'package:finora/domain/exception/taken_user_name_exception.dart';
import 'package:finora/domain/repositories/user_repository.dart';
import 'package:finora/domain/value_object/user_name.dart';

class UpdateUsernameUsecase {
  final UserRepository _userRepository;
  const UpdateUsernameUsecase({required this._userRepository});
  Future<User> changeUserUsername({
    required User user,
    required String userName,
  }) async {
    final bool isTaken = await _userRepository.isUsernameTaken(userName);
    if (!isTaken) {
      final newUserName = UserName.create(value: userName);
      final newUser = user.copyWith(userName: newUserName);
      await _userRepository.updateUser(newUser);
      return newUser;
    } else {
      throw TakenUserNameException(message: "This username is already taken.");
    }
  }
}
