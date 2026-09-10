import 'package:finora/data/mapper/user_mapper.dart';
import 'package:finora/data/models/user_model.dart';
import 'package:finora/domain/exception/user/not_valid_identical_user_id.dart';
import 'package:isar_community/isar.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class IsarUserRepository implements UserRepository {
  final Isar _isar;

  IsarUserRepository(this._isar);

  @override
  Future<void> saveUser(User user) async {
    final userModel = UserMapper.toModel(user);

    await _isar.writeTxn(() async {
      await _isar.userModels.put(userModel);
    });
  }

  @override
  Future<void> updateUser(User user) async {
    final existingUser = await _isar.userModels
        .filter()
        .idEqualTo(user.id.value)
        .findFirst();

    if (existingUser == null) {
      throw NotValidIdenticalUserId('this user not identical with new one');
    }

    final userModel = UserMapper.toModel(user);

    userModel.isarId = existingUser.isarId;

    await _isar.writeTxn(() async {
      await _isar.userModels.put(userModel);
    });
  }

  @override
  Future<bool> isUserNameTaken(String username) async {
    final user = await _isar.userModels
        .filter()
        .userNameEqualTo(username)
        .findFirst();

    return user != null;
  }

  @override
  Future<User?> getUserByUsername(String username) async {
    final userModel = await _isar.userModels
        .filter()
        .userNameEqualTo(username)
        .findFirst();

    if (userModel == null) {
      return null;
    }

    return UserMapper.toEntity(userModel);
  }
}
