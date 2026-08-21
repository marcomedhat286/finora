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
    await Future.delayed(Duration(seconds: 4));
    print("the new user has been saved : ${user.userName}");
  }

  @override
  Future<void> updateUser(User user) async {
    await Future.delayed(Duration(seconds: 4));
    print("the ${user.userName} user has been updated");
  }

  @override
  Future<bool> isUsernameTaken(String username) async {
    final list = ['marco_123', 'marco_1', "marco_34342", "marco_1223"];
    return (list.contains(username));
  }
}
