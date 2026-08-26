import 'package:finora/domain/enum/transaction/transaction_category_type.dart';
import 'package:finora/domain/validators/transactoin/expense_type_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum ExpenseCategory implements TransactionCategoryType {
  food(
    code: 'food',
    displayName: 'Food',
    icon: FontAwesomeIcons.bowlFood,
    iconColor: Color(0xFFFF6B6B),
  ),
  drink(
    code: 'drink',
    displayName: 'Drink',
    icon: FontAwesomeIcons.mugHot,
    iconColor: Color(0xFFFF6B6B),
  ),
  shopping(
    code: 'shopping',
    displayName: 'Shopping',
    icon: FontAwesomeIcons.cartShopping,
    iconColor: Color(0xFFFF9F43),
  ),
  housing(
    code: 'housing',
    displayName: 'Housing',
    icon: FontAwesomeIcons.house,
    iconColor: Color(0xFF54a0ff),
  ),
  transportation(
    code: 'transportation',
    displayName: 'Transportation',
    icon: FontAwesomeIcons.train,
    iconColor: Color(0xFF5f27cd),
  ),
  entertainment(
    code: 'entertainment',
    displayName: 'Entertainment',
    icon: FontAwesomeIcons.playstation,
    iconColor: Color(0xFFFF9FF3),
  ),
  health(
    code: 'health',
    displayName: 'Health',
    icon: FontAwesomeIcons.heartPulse,
    iconColor: Color(0xFF1dd1a1),
  ),
  education(
    code: 'education',
    displayName: 'Education',
    icon: FontAwesomeIcons.graduationCap,
    iconColor: Color(0xFF00d2d3),
  ),
  other(
    code: 'other',
    displayName: 'Other',
    icon: FontAwesomeIcons.ellipsis,
    iconColor: Color(0xFF8395a7),
  );

  @override
  final String code;

  @override
  final String displayName;

  @override
  final FaIconData icon;

  @override
  final Color iconColor;

  const ExpenseCategory({
    required this.code,
    required this.displayName,
    required this.icon,
    required this.iconColor,
  });

  factory ExpenseCategory.fromCode(String code) {
    return ExpenseTypeValidator.validateAndParse(code);
  }
}
