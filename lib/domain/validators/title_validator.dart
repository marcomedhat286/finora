import 'package:finora/domain/exception/empty_value_exception.dart';
import 'package:finora/domain/exception/invalid_format_exception.dart';
import 'package:finora/domain/Extensions/string_validate.dart';

abstract final class TitleValidator {
  static final RegExp _regExpTitle = RegExp(
    r'^[a-zA-Z0-9.\s\u0600-\u06FF]{3,25}$',
  );

  static String validateOrThrow({required String? title}) {
    if (title.isNullOrEmpty) {
      throw const EmptyValueException("The title must not be empty.");
    }

    final trimmedTitle = title!.trim();

    if (!trimmedTitle.isValid(_regExpTitle)) {
      throw InvalidFormatException(
        "The title must contain only letters and numbers (5-25 characters).",
      );
    }
    return trimmedTitle;
  }
}
