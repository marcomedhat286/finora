import 'package:finora/domain/enum/transaction/transaction_category_type.dart';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:finora/domain/enum/transaction/income_category.dart';

import 'package:finora/domain/enum/transaction/expense_category.dart';

/// Provides UI-specific properties for [IncomeCategory].
///
/// This extension keeps presentation concerns such as icons and colors
/// outside the Domain enum itself.
///
/// The [IncomeCategory] enum remains responsible only for representing
/// the business concept of an income category, while this extension maps
/// each category to its corresponding UI representation.
extension IncomeCategoryUI on IncomeCategory {
  /// Returns the Font Awesome icon associated with the income category.
  ///
  /// Each income category has its own visual representation to make it
  /// easier for users to identify the type of income.
  FaIconData get icon => switch (this) {
    IncomeCategory.salary => FontAwesomeIcons.sackDollar,
    IncomeCategory.freelance => FontAwesomeIcons.upwork,
    IncomeCategory.investments => FontAwesomeIcons.moneyBillTrendUp,
    IncomeCategory.gifts => FontAwesomeIcons.gifts,
    IncomeCategory.other => FontAwesomeIcons.ellipsis,
  };

  /// Returns the color used to represent the income category icon.
  ///
  /// The color is a presentation concern and therefore belongs in the
  /// UI extension rather than inside the Domain enum.
  Color get iconColor => switch (this) {
    IncomeCategory.salary => const Color(0xFF10AC84),
    IncomeCategory.freelance => const Color(0xFF2E86DE),
    IncomeCategory.investments => const Color(0xFF10AC84),
    IncomeCategory.gifts => const Color(0xFFF368E0),
    IncomeCategory.other => const Color(0xFF1DD1A1),
  };
}

/// Provides UI-specific properties for [ExpenseCategory].
///
/// Similar to [IncomeCategoryUI], this extension keeps UI-related
/// information separate from the Domain representation of expenses.
///
/// This allows the expense categories to remain independent from Flutter
/// and other presentation-specific dependencies.
extension ExpenseCategoryUI on ExpenseCategory {
  /// Returns the Font Awesome icon associated with the expense category.
  ///
  /// Each expense category is mapped to an icon that visually represents
  /// its purpose.
  FaIconData get icon => switch (this) {
    ExpenseCategory.food => FontAwesomeIcons.bowlFood,
    ExpenseCategory.drink => FontAwesomeIcons.mugHot,
    ExpenseCategory.shopping => FontAwesomeIcons.cartShopping,
    ExpenseCategory.housing => FontAwesomeIcons.house,
    ExpenseCategory.transportation => FontAwesomeIcons.train,
    ExpenseCategory.entertainment => FontAwesomeIcons.playstation,
    ExpenseCategory.health => FontAwesomeIcons.heartPulse,
    ExpenseCategory.education => FontAwesomeIcons.graduationCap,
    ExpenseCategory.other => FontAwesomeIcons.ellipsis,
  };

  /// Returns the color used to represent the expense category icon.
  ///
  /// The selected color provides a visual distinction between different
  /// types of expenses in the user interface.
  Color get iconColor => switch (this) {
    ExpenseCategory.food => const Color(0xFFFF6B6B),
    ExpenseCategory.drink => const Color(0xFFFF6B6B),
    ExpenseCategory.shopping => const Color(0xFFFF9F43),
    ExpenseCategory.housing => const Color(0xFF54A0FF),
    ExpenseCategory.transportation => const Color(0xFF5F27CD),
    ExpenseCategory.entertainment => const Color(0xFFFF9FF3),
    ExpenseCategory.health => const Color(0xFF1DD1A1),
    ExpenseCategory.education => const Color(0xFF00D2D3),
    ExpenseCategory.other => const Color(0xFF8395A7),
  };
}

/// Provides common UI properties for any [TransactionCategoryType].
///
/// Since both [IncomeCategory] and [ExpenseCategory] implement
/// [TransactionCategoryType], this extension provides a unified way
/// for the UI to retrieve icons and colors without needing to know
/// which concrete category type it received.
///
/// This is particularly useful for reusable widgets that display
/// both income and expense transactions.
extension TransactionCategoryTypeUI on TransactionCategoryType {
  /// Returns the appropriate icon for the current transaction category.
  ///
  /// The runtime type of the category determines whether the request
  /// should be delegated to [IncomeCategoryUI] or [ExpenseCategoryUI].
  ///
  /// A question-mark icon is returned as a safe fallback for an unsupported
  /// category implementation.
  FaIconData get icon => switch (this) {
    // Delegate the icon lookup to the income-specific UI extension.
    final IncomeCategory c => c.icon,

    // Delegate the icon lookup to the expense-specific UI extension.
    final ExpenseCategory c => c.icon,

    // Fallback icon for any future or unsupported category implementation.
    _ => FontAwesomeIcons.circleQuestion,
  };

  /// Returns the appropriate icon color for the current transaction category.
  ///
  /// The color lookup is delegated to the corresponding category-specific
  /// UI extension.
  ///
  /// A neutral gray color is returned as a fallback when the category type
  /// is not recognized.
  Color get iconColor => switch (this) {
    // Delegate the color lookup to the income-specific UI extension.
    final IncomeCategory c => c.iconColor,

    // Delegate the color lookup to the expense-specific UI extension.
    final ExpenseCategory c => c.iconColor,

    // Fallback color for unsupported category implementations.
    _ => Colors.grey,
  };
}
