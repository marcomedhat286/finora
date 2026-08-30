import 'package:finora/data/models/user_model.dart';
import 'package:finora/domain/entities/user.dart';
import 'package:finora/domain/value_object/user/birthday_date.dart';
import 'package:finora/domain/value_object/user/person_name.dart';
import 'package:finora/domain/value_object/user/profile_image_path.dart';
import 'package:finora/domain/value_object/user/user_id.dart';
import 'package:finora/domain/value_object/user/user_name.dart';

class UserMapper {
  static UserModel toModel(User user) {
    return UserModel()
      ..id = user.id.value
      ..userName = user.userName.value
      ..firstName = user.firstName.value
      ..middleName = user.middleName?.value
      ..lastName = user.lastName?.value
      ..createdAt = user.createdAt
      ..image = user.profileImage?.path
      ..birthdayDate = user.birthdayDate.value;
  }

  static User toEntity(UserModel model) {
    return User.create(
      id: UserId.create(model.id),
      userName: UserName.create(value: model.userName),
      firstName: PersonName.create(
        value: model.firstName,
        nameType: "first name",
      ),
      middleName: model.middleName == null
          ? null
          : PersonName.create(
              value: model.middleName!,
              nameType: "middle name",
            ),
      lastName: model.lastName == null
          ? null
          : PersonName.create(value: model.lastName!, nameType: "last name"),
      createdAt: model.createdAt,
      imagePath: model.image == null
          ? null
          : ProfileImage.create(imagePath: model.image!),
      birthDayDate: BirthdayDate.create(model.birthdayDate),
    );
  }
}
