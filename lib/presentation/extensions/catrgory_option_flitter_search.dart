import 'package:finora/presentation/extensions/catrgory_option_flitter_search_actions.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/flitter_option_button.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/flitter_search_option_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

extension CatrgoryOptionFlitterSearchUi on FlitterOptions {
  Widget uiButton(BuildContext buildContext) {
    switch (this) {
      case FlitterOptions.accountType:
        return FlitterOptionButton(
          icon: FontAwesomeIcons.landmark,
          optionName: "Account",
          onTap: actionButton(buildContext),
          flitterOption: this,
        );
      case FlitterOptions.transactionType:
        return FlitterOptionButton(
          icon: FontAwesomeIcons.moneyBillTransfer,
          optionName: "Type",
          onTap: actionButton(buildContext),
          flitterOption: this,
        );
      case FlitterOptions.dateRange:
        return FlitterOptionButton(
          icon: FontAwesomeIcons.calendarDays,
          optionName: "Date",
          onTap: actionButton(buildContext),
          flitterOption: this,
        );

      case FlitterOptions.amountRange:
        return FlitterOptionButton(
          icon: FontAwesomeIcons.dollarSign,
          optionName: "Amount",
          onTap: actionButton(buildContext),
          flitterOption: this,
        );
    }
  }
}
