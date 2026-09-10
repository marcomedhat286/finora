import 'package:finora/core/constants.dart';
import 'package:finora/data/models/user_model.dart';
import 'package:finora/domain/entities/transaction.dart';

import 'package:finora/presentation/controller/auth_user_controller.dart';
import 'package:finora/presentation/screens/home/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:isar_community/isar.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final List<Transaction> transactions =
          AuthUserController.to.userTransactions;
      final recentTransactions = transactions.reversed.take(10).toList();
      if (recentTransactions.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 40),
            child: Text(
              'No Transactions Yet',
              style: TextStyle(
                color: kPrimaryColor2,
                fontSize: smallSizeFont,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              height: 35,
              child: Row(
                children: [
                  Text(
                    "All Transactions (${transactions.length})",
                    style: const TextStyle(
                      color: kPrimaryColor2,
                      fontSize: smallSizeFont,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(flex: 1),
                  (transactions.length > 10)
                      ? TextButton(
                          onPressed: () {
                            print("all transactions");
                          },
                          child: Text(
                            "See All",
                            style: const TextStyle(
                              color: kPrimaryColor2,
                              fontSize: smallSizeFont,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : SizedBox(),
                  IconButton(
                    onPressed: () async {
                      final isar = Get.find<Isar>();
                      print(isar.isOpen);
                      print(isar.name);
                      print(isar.directory);
                      print(isar.path);
                      final users = await isar.userModels.where().findAll();
                      print('========== ALL USERS ==========');
                      print('Users count: ${users.length}');

                      for (final user in users) {
                        print('-------------------------------');
                        print('Isar ID      : ${user.isarId}');
                        print('ID           : ${user.id}');
                        print('Username     : ${user.userName}');
                        print('First Name   : ${user.firstName}');
                        print('Middle Name  : ${user.middleName}');
                        print('Last Name    : ${user.lastName}');
                        print('Created At   : ${user.createdAt}');
                        print('Image        : ${user.image}');
                        print('Birthday     : ${user.birthdayDate}');
                      }

                      print('===============================');

                      // if (savedUser == null) {
                      //   print('User was NOT found!');
                      //   return;
                      // }
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.ellipsis,
                      color: kPrimaryColor,
                      size: smallSizeFont * 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 300,
            child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: recentTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = recentTransactions[index];
                  return TransactionCard(transaction: transaction);
                },
              ),
            ),
          ),
        ],
      );
    });
  }
}
