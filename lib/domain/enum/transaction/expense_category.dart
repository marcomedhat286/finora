import 'package:finora/domain/enum/transaction/transaction_category_type.dart';
import 'package:finora/domain/validators/transaction/expense_type_validator.dart';

/// Represents the supported categories for expense transactions.
///
/// [ExpenseCategory] implements [TransactionCategoryType], ensuring that
/// every expense category exposes a stable internal [code] and a
/// human-readable [displayName].
///
/// The [code] is intended for internal operations such as persistence,
/// serialization, and comparison, while [displayName] is intended for
/// presentation to the user.
///
/// Keeping these two values separate allows the UI display name to change
/// without affecting the stored category identifier.
///
/// Example:
///
/// ```dart
/// ExpenseCategory.food.code;
/// // 'food'
///
/// ExpenseCategory.food.displayName;
/// // 'Food'
/// ```
enum ExpenseCategory implements TransactionCategoryType {
  /// Represents expenses related to food and meals.
  food(code: 'food', displayName: 'Food'),

  /// Represents expenses related to drinks and beverages.
  drink(code: 'drink', displayName: 'Drink'),

  /// Represents expenses related to shopping and purchased goods.
  shopping(code: 'shopping', displayName: 'Shopping'),

  /// Represents expenses related to housing and accommodation.
  housing(code: 'housing', displayName: 'Housing'),

  /// Represents expenses related to transportation and commuting.
  transportation(code: 'transportation', displayName: 'Transportation'),

  /// Represents expenses related to entertainment and recreational
  /// activities.
  entertainment(code: 'entertainment', displayName: 'Entertainment'),

  /// Represents expenses related to healthcare and medical needs.
  health(code: 'health', displayName: 'Health'),

  /// Represents expenses related to education and learning.
  education(code: 'education', displayName: 'Education'),

  /// Represents an expense that does not belong to any of the predefined
  /// categories.
  other(code: 'other', displayName: 'Other');

  /// Stable identifier used internally to represent this expense category.
  ///
  /// This value should remain stable because it may be stored in a database
  /// or used during serialization.
  @override
  final String code;

  /// Human-readable name used when displaying the category to the user.
  @override
  final String displayName;

  /// Creates an [ExpenseCategory] with its internal code and display name.
  const ExpenseCategory({required this.code, required this.displayName});

  /// Converts a raw category code into its corresponding [ExpenseCategory].
  ///
  /// The provided [code] is delegated to [ExpenseTypeValidator], which
  /// validates the value and returns the matching enum member.
  ///
  /// If the supplied code is not supported, the validator throws the
  /// appropriate domain exception.
  ///
  /// Example:
  ///
  /// ```dart
  /// final category = ExpenseCategory.fromCode('food');
  ///
  /// print(category); // ExpenseCategory.food
  /// ```
  factory ExpenseCategory.fromCode(String code) {
    return ExpenseTypeValidator.validateAndParse(code);
  }
}
