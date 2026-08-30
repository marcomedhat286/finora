import 'package:finora/domain/entities/user.dart';

abstract interface class UserRepository {
  Future<void> saveUser(User user);

  Future<void> updateUser(User user);

  Future<bool> isUserNameTaken(String username);
}
