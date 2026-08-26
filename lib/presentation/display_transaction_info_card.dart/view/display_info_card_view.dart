import 'package:finora/core/constants.dart';
import 'package:finora/domain/entities/income.dart';
import 'package:finora/domain/entities/transaction.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DisplayInfoCardView extends StatelessWidget {
  const DisplayInfoCardView({super.key, required this._transaction});
  final Transaction _transaction;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        height: double.infinity,
        child: DisplayInfoCardBody(transaction: _transaction),
      ),
    );
  }
}

class DisplayInfoCardBody extends StatelessWidget {
  const DisplayInfoCardBody({super.key, required this._transaction});

  final Transaction _transaction;

  @override
  Widget build(BuildContext context) {
    const double fullRadiusCricle = 175;
    const double verticalSpace = 10;
    final isIncome = (_transaction.runtimeType == Income);
    return Align(
      alignment: AlignmentGeometry.xy(0, -0.3),
      child: Container(
        width: double.infinity,
        height: 600,
        margin: const EdgeInsets.symmetric(horizontal: 30),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              blurRadius: 50,
              color: Colors.blueGrey,
              offset: Offset.zero,
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 70),
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
                            style: TextStyle(
                              color: isIncome ? Colors.green : Colors.red,
                            ),
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
                      const SizedBox(height: verticalSpace * 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor,
                            ),
                            onPressed: () {
                              print("edit");
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),

                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: kPrimaryColor,
                                    blurRadius: blurRadius,
                                    spreadRadius: 8,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: const Text(
                                "Edit",
                                style: TextStyle(color: kSecondColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor,
                            ),
                            onPressed: () {
                              print("delete");
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),

                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: kPrimaryColor,
                                    blurRadius: blurRadius,
                                    spreadRadius: 8,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: const Text(
                                "Delete",
                                style: TextStyle(color: kSecondColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: AlignmentGeometry.xy(0, -0.75),
              child: SizedBox(
                height: fullRadiusCricle,
                width: fullRadiusCricle,
                child: CircleAvatar(
                  backgroundColor: Colors.grey.withAlpha(150),
                  child: FaIcon(
                    _transaction.category.icon,
                    color: _transaction.category.iconColor,
                    size: fullRadiusCricle / 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}  ${date.hour}:${date.minute}';
  }
}
