import 'package:finora/presentation/core/show_dialog.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/account_options_ui_body.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/amount_range_option_ui_body.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/date_range_options_ui_body.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/flitter_search_option_list.dart';
import 'package:finora/presentation/screens/transaction_search/widgets/transaction_options_ui_body.dart';
import 'package:flutter/material.dart';

extension CatrgoryOptionFlitterSearchActions on FlitterOptions {
  GestureTapCallback actionButton(BuildContext buildContext) {
    switch (this) {
      case FlitterOptions.accountType:
        return () async {
          await ShowDialog.showFlitterOptionsDialog(
            buildContext: buildContext,
            body: const AccountOptionsUiBody(),
          );
        };

      case FlitterOptions.transactionType:
        return () async {
          await ShowDialog.showFlitterOptionsDialog(
            buildContext: buildContext,
            body: const TransactionOptionsUiBody(),
          );
        };
      case FlitterOptions.dateRange:
        return () async {
          await ShowDialog.showFlitterOptionsDialog(
            buildContext: buildContext,
            body: const DateRangeOptionsUiBody(),
          );
        };
      case FlitterOptions.amountRange:
        return () async {
          await ShowDialog.showFlitterOptionsDialog(
            buildContext: buildContext,
            body: const AmountRangeOptionUiBody(),
          );
        };
    }
  }
}
