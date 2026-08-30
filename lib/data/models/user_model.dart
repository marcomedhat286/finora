import 'package:isar_community/isar.dart';

part 'user_model.g.dart';

@collection
class UserModel {
  Id isarId = Isar.autoIncrement;

  late String id;

  late String userName;

  late String firstName;

  String? middleName;

  String? lastName;

  late DateTime createdAt;

  String? image;

  late DateTime birthdayDate;
}
