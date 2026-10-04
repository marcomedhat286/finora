import 'package:finora/domain/enum/account/account_type.dart';
import 'package:finora/domain/value_object/account/account_potions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

extension CategoryAccountUiExtension on AccountOption {
  FaIconData get icon {
    if (accountType == null) {
      return FontAwesomeIcons.buildingColumns;
    }
    switch (accountType!) {
      case AccountType.bank:
        return FontAwesomeIcons.buildingColumns;
      case AccountType.cash:
        return FontAwesomeIcons.wallet;
      case AccountType.creditCard:
        return FontAwesomeIcons.creditCard;
      case AccountType.savings:
        return FontAwesomeIcons.ccVisa;
      case AccountType.investment:
        return FontAwesomeIcons.moneyBillTrendUp;
    }
  }

  Color get iconColor {
    if (accountType == null) {
      return const Color.fromARGB(255, 202, 86, 140);
    }
    switch (accountType!) {
      case AccountType.bank:
        return const Color(0xFF10AC84);
      case AccountType.cash:
        return const Color(0xFF2E86DE);
      case AccountType.creditCard:
        return const Color.fromARGB(255, 223, 208, 80);
      case AccountType.savings:
        return const Color(0xFFF368E0);
      case AccountType.investment:
        return const Color(0xFF1DD1A1);
    }
  }
}
