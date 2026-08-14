import 'package:finora/domain/entities/user.dart';

import 'package:finora/domain/repositories/user_repository.dart';
import 'package:finora/domain/value_object/birthday_date.dart';
import 'package:finora/domain/value_object/person_name.dart';
import 'package:finora/domain/value_object/profile_image_path.dart';

class UpdateProfileInfoUseCase {
  final UserRepository _userRepository;
  const UpdateProfileInfoUseCase({required this._userRepository});

  Future<User> updateUserInfo({
    required User oldUser,
    String? firstName,
    Object? imageProfilePath = User.sentinel,
    DateTime? birthdayDate,
    Object? middleName = User.sentinel,
    Object? lastName = User.sentinel,
  }) async {
    final newFirstName = (firstName != null)
        ? PersonName.create(value: firstName, nameType: "first name")
        : oldUser.firstName;

    final newMiddleName = (middleName == User.sentinel)
        ? oldUser.middleName
        : (middleName == null)
        ? null
        : PersonName.create(
            value: middleName as String,
            nameType: "middle name",
          );

    final newLastName = (lastName == User.sentinel)
        ? oldUser.lastName
        : (lastName == null)
        ? null
        : PersonName.create(value: lastName as String, nameType: "last name");

    final newBirthdayDate = (birthdayDate != null)
        ? BirthdayDate.create(birthdayDate)
        : oldUser.birthdayDate;

    final newProfileImage = (imageProfilePath == User.sentinel)
        ? oldUser.profileImage
        : (imageProfilePath == null)
        ? null
        : ProfileImage.create(imagePath: imageProfilePath as String);

    final updatedUser = oldUser.copyWith(
      firstName: newFirstName,
      middleName: newMiddleName,
      lastName: newLastName,
      BirthdayDate: newBirthdayDate,
      profileImagePath: newProfileImage,
    );
    await _userRepository.updateUser(updatedUser);

    return updatedUser;
  }
}
