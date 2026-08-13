import 'package:finora/domain/entities/user.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/exception/taken_user_name_exception.dart';
import 'package:finora/domain/repositories/user_repository.dart';
import 'package:finora/domain/services/convert_string_todouble_balance.dart';
import 'package:finora/domain/value_object/birthday_date.dart';
import 'package:finora/domain/value_object/person_name.dart';
import 'package:finora/domain/value_object/profile_image_path.dart';
import 'package:finora/domain/value_object/user_name.dart';
import 'package:finora/domain/services/account_id_generator.dart';
import 'package:finora/domain/services/user_name_generator.dart';

class RegisterUserUseCase {
  final UserRepository _userRepository;
  const RegisterUserUseCase.RegisterNewUserUseCase({
    required this._userRepository,
  });

  Future<User> excuteNewOne({
    String? user_name,
    required String firstName,
    required String initialBalance,
    required DateTime? birthDate,
    String? middleName,
    String? lastName,
  }) async {
    final firstNamePerson = PersonName.create(
      value: firstName,
      nameType: "first name",
    );
    PersonName? middleNamePerson;
    PersonName? lastNamePerson;

    /// Validate optional middle name only when supplied.
    if (middleName != null) {
      middleNamePerson = PersonName.create(
        value: middleName,
        nameType: "middle name",
      );
    }

    /// Validate optional last name only when supplied.
    if (lastName != null) {
      lastNamePerson = PersonName.create(
        value: lastName,
        nameType: "last name",
      );
    }

    final BirthdayDate birthdayDate = BirthdayDate.create(birthDate);
    final now = DateTime.now();

    Account initialAccount = _getNewAccount(
      initialBalance: initialBalance,
      createdAt: now,
    );

    final newUserName = await _getNewUserName(user_name, firstName);

    final user = User(
      userName: newUserName,
      firstName: firstNamePerson,
      account: initialAccount,
      middleName: middleNamePerson,
      lastName: lastNamePerson,
      createdAt: now,
      birthdayDate: birthdayDate,
      image: ProfileImage.create(imagePath: null),
    );
    await _userRepository.saveUser(user);

    return user;
  }

  Account _getNewAccount({
    required String initialBalance,
    required DateTime createdAt,
  }) {
    final newIdAccount = AccountIDGenerator.generateAccountId();
    final initialBalanceDouble = ConvertStringTodoubleBalance.convert(
      value: initialBalance,
      valueName: "initial balance",
    );

    final initialAccount = Account.create(
      id: newIdAccount,
      initialBalance: initialBalanceDouble,
      createdAt: createdAt,
    );
    return initialAccount;
  }

  Future<UserName> _getNewUserName(String? userName, String firstName) async {
    if (userName != null) {
      return isTaken(userName);
    } else {
      final newUserName = UserNameGenerator.generateUserName(name: firstName);
      return isTaken(newUserName.value);
    }
  }

  Future<UserName> isTaken(String userName) async {
    final isTaken = await _userRepository.isUsernameTaken(userName);
    if (!isTaken) {
      return UserName.create(value: userName);
    } else {
      throw TakenUserNameException(message: "This Username is already taken.");
    }
  }
}
