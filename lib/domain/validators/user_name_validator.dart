import 'package:finora/domain/exception/empty_value_exception.dart';
import 'package:finora/domain/exception/invalid_format_exception.dart';

abstract final class UserNameValidator {
  static final RegExp _regex = RegExp(r'^[A-Za-z]{3,12}[@_-]\d{1,10}$');

  static String validateOrThrow(String userName) {
    final trimmedUserName = userName.trim();
    if (trimmedUserName.isEmpty) {
      throw const EmptyValueException("UserName can't be empty.");
    }

    if (!_regex.hasMatch(trimmedUserName)) {
      throw const InvalidFormatException(
        "Invalid username format. Expected: 3-12 letters + (@ or _ or -) + 1-10 digits.",
      );
    }
    return trimmedUserName;
  }
}
