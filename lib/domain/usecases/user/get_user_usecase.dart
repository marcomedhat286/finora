import 'package:finora/domain/entities/user.dart';
import 'package:finora/domain/exception/user/not_found_user_exception.dart';
import 'package:finora/domain/repositories/user_repository.dart';
import 'package:finora/domain/validators/user/user_name_validator.dart';

class GetUserByUsernameUseCase {
  final UserRepository _userRepository;

  GetUserByUsernameUseCase({required this._userRepository});

  Future<User> execute(String username) async {
    UserNameValidator.validateOrThrow(username);
    final user = await _userRepository.getUserByUsername(username);
    if (user == null) {
      throw NotFoundUserException("This user is not found.");
    }
    return user;
  }
}
