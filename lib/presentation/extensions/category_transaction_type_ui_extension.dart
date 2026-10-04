import 'package:finora/domain/enum/transaction/transaction_type_option.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

extension CategoryTransactiontypeUiExtension on TransactionTypeOptions {
  FaIconData get icon {
    switch (this) {
      case TransactionTypeOptions.all:
        return FontAwesomeIcons.upDown;
      case TransactionTypeOptions.income:
        return FontAwesomeIcons.arrowDown;
      case TransactionTypeOptions.expense:
        return FontAwesomeIcons.arrowUp;
    }
  }

  Color get color {
    switch (this) {
      case TransactionTypeOptions.all:
        return Colors.blueAccent;
      case TransactionTypeOptions.income:
        return Colors.lightGreenAccent;
      case TransactionTypeOptions.expense:
        return Colors.redAccent;
    }
  }
}
