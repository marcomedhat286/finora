import 'package:finora/domain/Extensions/string_validate.dart';
import 'package:finora/domain/enum/transaction/expense_category.dart';
import 'package:finora/domain/exception/transaction/invalid_expense_type_exception.dart';
import 'package:finora/domain/exception/user/empty_value_exception.dart';

/// Validates and parses raw expense category codes.
///
/// [ExpenseTypeValidator] is responsible for taking an external/raw
/// category code and converting it into a valid [ExpenseCategory].
///
/// The validation process ensures that:
///
/// - The provided code is not null or empty.
/// - Leading and trailing whitespace is removed.
/// - The code comparison is case-insensitive.
/// - The code matches one of the supported [ExpenseCategory] values.
///
/// This keeps category validation inside the Domain layer and prevents
/// invalid expense types from entering the domain model.
///
/// Example:
///
/// ```dart
/// final category = ExpenseTypeValidator.validateAndParse('food');
///
/// print(category); // ExpenseCategory.food
/// ```
///
/// An exception is thrown when the supplied code is empty or does not
/// represent a supported expense category.
abstract final class ExpenseTypeValidator {
  /// Validates an expense category code and converts it into
  /// an [ExpenseCategory].
  ///
  /// The method performs the following steps:
  ///
  /// 1. Checks whether [code] is null or empty.
  /// 2. Trims leading and trailing whitespace.
  /// 3. Converts the code to lowercase to make comparison case-insensitive.
  /// 4. Searches through all supported [ExpenseCategory] values.
  /// 5. Returns the matching category when found.
  ///
  /// Throws:
  ///
  /// - [EmptyValueException] when [code] is null or empty.
  /// - [InvalidExpenseTypeException] when the code does not match any
  ///   supported expense category.
  static ExpenseCategory validateAndParse(String? code) {
    // Reject null or empty values before attempting to process the code.
    if (code.isNullOrEmpty) {
      throw const EmptyValueException("The expense type must not be empty");
    }

    // Normalize the input so that values such as
    // " Food ", "FOOD", and "food" are treated consistently.
    final cleanCode = code!.trim().toLowerCase();

    // Search for a category whose internal code matches the normalized value.
    return ExpenseCategory.values.firstWhere(
      (type) => type.code == cleanCode,

      // If no category matches the provided code, reject the value
      // instead of allowing an invalid category into the domain.
      orElse: () =>
          throw InvalidExpenseTypeException("Invalid expense type : $code"),
    );
  }
}
