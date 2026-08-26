import 'package:finora/domain/enum/transaction/transaction_category_type.dart';
import 'package:finora/domain/validators/transactoin/income_type_validator.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum IncomeCategory implements TransactionCategoryType {
  salary(
    code: 'salary',
    displayName: 'Salary',
    icon: FontAwesomeIcons.sackDollar,
    iconColor: Color(0xFF10ac84),
  ),
  freelance(
    code: 'freelance',
    displayName: 'Freelance',
    icon: FontAwesomeIcons.upwork,
    iconColor: Color(0xFF2e86de),
  ),
  investments(
    code: 'investments',
    displayName: 'Investments',
    icon: FontAwesomeIcons.moneyBillTrendUp,
    iconColor: Color(0xFF10ac84),
  ),
  gifts(
    code: 'gifts',
    displayName: 'Gifts',
    icon: FontAwesomeIcons.gifts,
    iconColor: Color(0xFFf368e0),
  ),
  other(
    code: 'other',
    displayName: 'other',
    icon: FontAwesomeIcons.ellipsis,
    iconColor: Color(0xFF1dd1a1),
  );

  @override
  final String code;

  @override
  final String displayName;

  @override
  final FaIconData icon;

  @override
  final Color iconColor;

  const IncomeCategory({
    required this.code,
    required this.displayName,
    required this.icon,
    required this.iconColor,
  });

  factory IncomeCategory.fromCode(String code) {
    return IncomeTypeValidator.validateAndParse(code);
  }
}
