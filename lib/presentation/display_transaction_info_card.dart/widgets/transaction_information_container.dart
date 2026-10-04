import 'package:finora/core/constants.dart';
import 'package:finora/domain/entities/income.dart';
import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/presentation/controller/auth_accounts_controller.dart';
import 'package:finora/presentation/display_transaction_info_card.dart/widgets/action_transaction_button.dart';
import 'package:flutter/material.dart';

class TransactionInformationContainer extends StatelessWidget {
  const TransactionInformationContainer({
    super.key,
    required this._transaction,
  });

  final Transaction _transaction;

  @override
  Widget build(BuildContext context) {
    const double verticalSpace = 10;
    final isIncome = (_transaction.runtimeType == Income);
    final account = AuthAccountsController.to.getAccountById(
      _transaction.accountId,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _transaction.category.displayName,
            style: const TextStyle(
              fontSize: bigSizeFont,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: verticalSpace),
          Text(
            "TITLE:\t${_transaction.title.value}",
            style: const TextStyle(
              fontSize: middleSizeFont / 1.3,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: verticalSpace),
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Text(
              "DESCRIPTION:\t${_transaction.description ?? "No description"}",
              overflow: .fade,
              style: const TextStyle(
                fontSize: smallSizeFont,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          const SizedBox(height: verticalSpace),
          Row(
            children: [
              Text(
                "amount:".toUpperCase(),
                style: const TextStyle(
                  fontSize: smallSizeFont,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(width: 15),
              Text(
                "${isIncome ? "" : "-"}${_transaction.amount.value} EGP",
                style: TextStyle(color: isIncome ? Colors.green : Colors.red),
              ),
            ],
          ),
          const SizedBox(height: verticalSpace),
          Row(
            children: [
              Text(
                "created at:".toUpperCase(),
                style: const TextStyle(
                  fontSize: smallSizeFont,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(width: 15),
              Text(
                _formatDate(_transaction.createdAt),
                style: const TextStyle(
                  fontSize: smallSizeFont,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          const SizedBox(height: verticalSpace),
          Row(
            children: [
              Text(
                "account name".toUpperCase(),
                style: const TextStyle(
                  fontSize: smallSizeFont,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(width: 15),
              Text(
                account.name.value,
                style: const TextStyle(
                  fontSize: smallSizeFont,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          const SizedBox(height: verticalSpace),
          Row(
            children: [
              Text(
                "account Id".toUpperCase(),
                style: const TextStyle(
                  fontSize: smallSizeFont,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(width: 15),
              Text(
                _accountIdFormat(account.id.value),
                style: const TextStyle(
                  fontSize: smallSizeFont,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          const SizedBox(height: verticalSpace * 3),
          Row(
            mainAxisAlignment: .center,
            children: [
              ActionTransactionButton(actionName: "edit"),
              ActionTransactionButton(actionName: "delete"),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}  ${date.hour}:${date.minute}';
  }

  String _accountIdFormat(String accountId) {
    return accountId.split("-").last;
  }
}
