import 'package:finora/domain/entities/user.dart';

abstract interface class UserRepository {
  factory UserRepository() => FakeUserRepository();
  Future<void> saveUser(User user);
  Future<void> updateUser(User user);
  Future<bool> isUsernameTaken(String username);
}

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
