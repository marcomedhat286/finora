import 'package:finora/domain/enum/transaction/transaction_category_type.dart';
import 'package:finora/domain/validators/transaction/income_type_validator.dart';

/// Represents the supported categories for income transactions.
///
/// [IncomeCategory] implements [TransactionCategoryType], which means every
/// income category provides:
///
/// - [code] → A stable internal identifier used for persistence,
///   serialization, and comparison.
/// - [displayName] → A human-readable name intended for presentation.
///
/// Keeping the internal [code] separate from the [displayName] allows the
/// displayed text to change without affecting stored data.
///
/// Example:
///
/// ```dart
/// IncomeCategory.salary.code
/// // 'salary'
///
/// IncomeCategory.salary.displayName
/// // 'Salary'
/// ```
enum IncomeCategory implements TransactionCategoryType {
  /// Represents income received as a regular salary.
  salary(code: 'salary', displayName: 'Salary'),

  /// Represents income earned from freelance work.
  freelance(code: 'freelance', displayName: 'Freelance'),

  /// Represents income generated from investments.
  investments(code: 'investments', displayName: 'Investments'),

  /// Represents money received as a gift.
  gifts(code: 'gifts', displayName: 'Gifts'),

  /// Represents income that does not belong to any of the predefined
  /// categories.
  other(code: 'other', displayName: 'Other');

  /// Stable identifier used to represent the category internally.
  @override
  final String code;

  /// Human-readable name used when displaying the category to the user.
  @override
  final String displayName;

  /// Creates an [IncomeCategory] with its internal [code] and display name.
  const IncomeCategory({required this.code, required this.displayName});

  /// Converts a stored category code into its corresponding
  /// [IncomeCategory].
  ///
  /// The code is passed to [IncomeTypeValidator], which is responsible for
  /// validating the value and returning the matching enum member.
  ///
  /// Throws an exception when the supplied code does not represent a
  /// supported income category.
  ///
  /// Example:
  ///
  /// ```dart
  /// final category = IncomeCategory.fromCode('salary');
  ///
  /// print(category); // IncomeCategory.salary
  /// ```
  factory IncomeCategory.fromCode(String code) {
    return IncomeTypeValidator.validateAndParse(code);
  }
}
