import 'package:finora/domain/value_object/birthday_date.dart';
import 'package:finora/domain/value_object/person_name.dart';
import 'package:finora/domain/value_object/profile_image_path.dart';
import 'package:finora/domain/value_object/user_id.dart';
import 'package:finora/domain/value_object/user_name.dart';

class User {
  static const Object sentinel = Object();

  final UserName _userName;
  final UserId _id;

  final PersonName _firstName;

  final PersonName? _middleName;

  final PersonName? _lastName;

  final DateTime _createdAt;

  final ProfileImage? _image;

  final BirthdayDate _birthdayDate;

  const User({
    required this._userName,
    required this._id,
    required this._firstName,

    required this._createdAt,
    required this._image,
    required this._birthdayDate,
    this._middleName,
    this._lastName,
  });

  // factory User._create({
  //   required String userName,
  //   required String firstName,
  //   required Account account,
  //   required DateTime createdAt,
  //   required DateTime birthDate,
  //   required String? imagePath,
  //   String? middleName,
  //   String? lastName,
  // }) {
  //   final userNameInst = UserName.create(value: userName);

  //   final firstNamePerson = PersonName.create(
  //     value: firstName,
  //     nameType: "first name",
  //   );

  //   PersonName? middleNamePerson;
  //   PersonName? lastNamePerson;

  //   if (middleName != null) {
  //     middleNamePerson = PersonName.create(
  //       value: middleName,
  //       nameType: "middle name",
  //     );
  //   }

  //   if (lastName != null) {
  //     lastNamePerson = PersonName.create(
  //       value: lastName,
  //       nameType: "last name",
  //     );
  //   }

  //   final birhtdayDate = BirthdayDate.create(birthDate);

  //   CreatedAtValidator.validateOrThrow(createdAt);
  //   ProfileImage? profileImage = (imagePath != null)
  //       ? ProfileImage.create(imagePath: imagePath)
  //       : null;

  //   return User(
  //     userName: userNameInst,
  //     firstName: firstNamePerson,
  //     middleName: middleNamePerson,
  //     lastName: lastNamePerson,
  //     account: account,
  //     createdAt: createdAt,
  //     image: profileImage,
  //     birthdayDate: birhtdayDate,
  //   );
  // }

  User copyWith({
    UserName? userName,
    PersonName? firstName,
    Object? middleName = sentinel,
    Object? lastName = sentinel,
    Object? profileImagePath = sentinel,
    BirthdayDate? BirthdayDate,
  }) {
    return User(
      id: _id,
      userName: (userName == null) ? _userName : userName,
      firstName: (firstName == null) ? _firstName : firstName,

      createdAt: _createdAt,
      birthdayDate: BirthdayDate ?? _birthdayDate,
      image: profileImagePath == sentinel
          ? _image
          : profileImagePath as ProfileImage?,
      middleName: middleName == sentinel
          ? _middleName
          : middleName as PersonName?,
      lastName: lastName == sentinel ? _lastName : lastName as PersonName?,
    );
  }

  Map<String, dynamic> toMap() => {
    "userName": _userName.value,
    "firstName": _firstName.value,
    "middleName": _middleName?.value,
    "lastName": _lastName?.value,

    "createdAt": _createdAt.toIso8601String(),
    "imagePath": _image?.path,
    'birthdayDate': _birthdayDate.formattedDate,
  };

  UserName get userName => _userName;
  UserId get id => _id;

  PersonName get firstName => _firstName;

  PersonName? get middleName => _middleName;

  PersonName? get lastName => _lastName;

  DateTime get createdAt => _createdAt;

  ProfileImage? get profileImage => _image;

  BirthdayDate get birthdayDate => _birthdayDate;

  String get fullName {
    return [
      firstName.value,
      if (middleName != null) middleName!.value,
      if (lastName != null) lastName!.value,
    ].join(' ');
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is User &&
            other._userName == _userName &&
            other._firstName == _firstName &&
            other._middleName == _middleName &&
            other._lastName == _lastName &&
            other._createdAt == _createdAt &&
            other._image == _image &&
            other._birthdayDate == _birthdayDate);
  }

  @override
  int get hashCode {
    return Object.hash(
      _userName,
      _firstName,
      _middleName,
      lastName,

      _createdAt,
      _birthdayDate,
      _image,
    );
  }

  @override
  String toString() =>
      """
  User name: ${_userName.value}
  Name: $fullName
 
  created at: $_createdAt
  Image Path: ${_image?.path}""";
}
