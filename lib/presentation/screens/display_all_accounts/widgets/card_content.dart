import 'package:finora/presentation/screens/display_all_accounts/widgets/current_and_date_card.dart';
import 'package:finora/presentation/screens/display_all_accounts/widgets/name_and_id_card.dart';
import 'package:finora/presentation/screens/display_all_accounts/widgets/type_card.dart';
import 'package:flutter/material.dart';

class CardContent extends StatelessWidget {
  const CardContent({
    super.key,
    required this.type,
    required this.title,
    required this.accountId,
    required this.currentBalance,
    required this.createdAt,
  });

  final String type;
  final String title;
  final String accountId;
  final String currentBalance;
  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row
          TypeCard(type: type),
          const Spacer(),

          // Card holder name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NameAndIdCard(title: title, accountId: accountId),
              CurrentAndDateCard(
                currentBalance: currentBalance,
                createdAt: createdAt,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
