import 'package:finora/domain/exception/empty_value_exception.dart';
import 'package:finora/domain/exception/invalid_format_exception.dart';

abstract final class AccountIdValidator {
  static final RegExp _uuidRegex = RegExp(
    r'^acc_[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-4[0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$',
  );

  static String validateOrThrow(String accountId) {
    final trimmedAccountId = accountId.trim();

    if (trimmedAccountId.isEmpty) {
      throw const EmptyValueException("Account ID must not be empty.");
    }

    if (!_uuidRegex.hasMatch(trimmedAccountId)) {
      throw InvalidFormatException(
        "Invalid Account ID format: $trimmedAccountId",
      );
    }

    return trimmedAccountId;
  }
}
