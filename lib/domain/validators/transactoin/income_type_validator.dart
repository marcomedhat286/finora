import 'package:finora/domain/enum/transaction/income_category.dart';
import 'package:finora/domain/exception/transaction/invalid_income_type_exception.dart';
import 'package:finora/domain/exception/user/empty_value_exception.dart';

abstract final class IncomeTypeValidator {
  static IncomeCategory validateAndParse(String? code) {
    if (code == null || code.trim().isEmpty) {
      throw EmptyValueException("The income type must not be empty");
    }

    final cleanCode = code.trim().toLowerCase();

    return IncomeCategory.values.firstWhere(
      (type) => type.code == cleanCode,
      orElse: () =>
          throw InvalidIncomeTypeException("Invalid income type : $code"),
    );
  }
}
