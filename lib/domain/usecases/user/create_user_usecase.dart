import 'package:finora/domain/entities/user.dart';
import 'package:finora/domain/exception/taken_user_name_exception.dart';
import 'package:finora/domain/repositories/user_repository.dart';
import 'package:finora/domain/services/identity_generator.dart';
import 'package:finora/domain/value_object/birthday_date.dart';
import 'package:finora/domain/value_object/person_name.dart';
import 'package:finora/domain/value_object/user_id.dart';
import 'package:finora/domain/value_object/user_name.dart';

import 'package:finora/domain/services/user_name_generator.dart';

class CreateUserUseCase {
  final UserRepository _userRepository;

  static const int _maxUsernameGenerationAttempts = 5;

  const CreateUserUseCase({required this._userRepository});

  Future<User> execute({
    String? userName,
    required String firstName,

    required DateTime? birthDate,
    String? middleName,
    String? lastName,
  }) async {
    final firstNamePerson = PersonName.create(
      value: firstName,
      nameType: 'first name',
    );

    PersonName? middleNamePerson;
    PersonName? lastNamePerson;

    if (middleName != null) {
      middleNamePerson = PersonName.create(
        value: middleName,
        nameType: 'middle name',
      );
    }

    if (lastName != null) {
      lastNamePerson = PersonName.create(
        value: lastName,
        nameType: 'last name',
      );
    }

    final BirthdayDate birthdayDate = BirthdayDate.create(birthDate);

    final now = DateTime.now();

    final newUserName = await _getNewUserName(userName, firstName);
    final id = UserId.create(IdentityGenerator.generateUuid());
    final user = User(
      id: id,
      userName: newUserName,
      firstName: firstNamePerson,
      middleName: middleNamePerson,
      lastName: lastNamePerson,
      createdAt: now,
      birthdayDate: birthdayDate,
      image: null,
    );
    await _userRepository.saveUser(user);

    return user;
  }

  Future<UserName> _getNewUserName(String? userName, String firstName) async {
    if (userName != null) {
      return await _getValidatedUserName(userName);
    }

    return await _retryGenerateUseraNameLoop(firstName);
  }

  Future<UserName> _retryGenerateUseraNameLoop(String firstName) async {
    final newUserName = UserNameGenerator.generate(name: firstName);

    final isTaken = await _userRepository.isUsernameTaken(newUserName.value);

    if (!isTaken) {
      return newUserName;
    }

    for (
      int loopIndex = 0;
      loopIndex < _maxUsernameGenerationAttempts;
      loopIndex++
    ) {
      final newUserNameInLoop = UserNameGenerator.generate(name: firstName);

      final isTaken = await _userRepository.isUsernameTaken(
        newUserNameInLoop.value,
      );

      if (isTaken) {
        continue;
      }

      return newUserNameInLoop;
    }

    throw TakenUserNameException(message: 'Sorry, can u retry laiter.');
  }

  Future<UserName> _getValidatedUserName(String userName) async {
    final isTaken = await _userRepository.isUsernameTaken(userName);

    if (!isTaken) {
      return UserName.create(value: userName);
    }

    throw TakenUserNameException(message: 'This Username is already taken.');
  }
}
