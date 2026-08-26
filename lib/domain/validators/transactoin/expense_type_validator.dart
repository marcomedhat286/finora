import 'package:finora/domain/enum/transaction/expense_category.dart';
import 'package:finora/domain/exception/transaction/invalid_expense_type_exception.dart';
import 'package:finora/domain/exception/user/empty_value_exception.dart';

abstract final class ExpenseTypeValidator {
  static ExpenseCategory validateAndParse(String? code) {
    if (code == null || code.trim().isEmpty) {
      throw EmptyValueException("The expense type must not be empty");
    }

    final cleanCode = code.trim().toLowerCase();

    return ExpenseCategory.values.firstWhere(
      (type) => type.code == cleanCode,
      orElse: () =>
          throw InvalidExpenseTypeException("Invalid expense type : $code"),
    );
  }
}
