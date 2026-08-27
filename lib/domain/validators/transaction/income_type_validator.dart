import 'package:finora/domain/Extensions/string_validate.dart';
import 'package:finora/domain/enum/transaction/income_category.dart';
import 'package:finora/domain/exception/transaction/invalid_income_type_exception.dart';
import 'package:finora/domain/exception/user/empty_value_exception.dart';

/// Validates and parses raw income category codes.
///
/// [IncomeTypeValidator] is responsible for receiving an external/raw
/// income category code and converting it into a valid [IncomeCategory].
///
/// The validator ensures that:
///
/// - The provided code is not null or empty.
/// - Leading and trailing whitespace is removed.
/// - The code is normalized to lowercase.
/// - The normalized code matches one of the supported [IncomeCategory] values.
///
/// By keeping this logic inside the Domain layer, invalid income categories
/// are prevented from entering the domain model.
///
/// Example:
///
/// ```dart
/// final category = IncomeTypeValidator.validateAndParse('salary');
///
/// print(category); // IncomeCategory.salary
/// ```
///
/// The method throws a domain-specific exception when the supplied code
/// cannot be converted into a supported income category.
abstract final class IncomeTypeValidator {
  /// Validates an income category code and converts it into an
  /// [IncomeCategory].
  ///
  /// The validation process performs the following steps:
  ///
  /// 1. Checks whether [code] is null or empty.
  /// 2. Removes leading and trailing whitespace.
  /// 3. Converts the code to lowercase.
  /// 4. Searches through all supported [IncomeCategory] values.
  /// 5. Returns the matching category.
  ///
  /// Throws:
  ///
  /// - [EmptyValueException] when [code] is null or empty.
  /// - [InvalidIncomeTypeException] when the code does not match any
  ///   supported income category.
  static IncomeCategory validateAndParse(String? code) {
    // Reject null or empty values before processing the category code.
    if (code.isNullOrEmpty) {
      throw const EmptyValueException("The income type must not be empty");
    }

    // Normalize the input to make the category lookup consistent.
    //
    // For example:
    // " Salary " → "salary"
    // "SALARY"  → "salary"
    final cleanCode = code!.trim().toLowerCase();

    // Search for the income category whose internal code matches
    // the normalized input.
    return IncomeCategory.values.firstWhere(
      (type) => type.code == cleanCode,

      // Reject unsupported category codes instead of allowing an
      // invalid income type into the domain.
      orElse: () =>
          throw InvalidIncomeTypeException("Invalid income type : $code"),
    );
  }
}
