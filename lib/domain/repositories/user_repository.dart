import 'package:finora/domain/entities/user.dart';
import 'package:finora/test.dart';

abstract interface class UserRepository {
  factory UserRepository() => FakeUserRepository();
  Future<void> saveUser(User user);
  Future<void> updateUser(User user);
  Future<bool> isUsernameTaken(String username);
}
