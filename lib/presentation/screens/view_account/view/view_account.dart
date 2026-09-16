import 'package:finora/core/constants.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/presentation/screens/view_account/widgets/view_account_body.dart';
import 'package:flutter/material.dart';

class ViewAccount extends StatelessWidget {
  final Account _account;
  final List<Color> _colors;
  const ViewAccount({super.key, required this._account, required this._colors});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondColor,
      body: ViewAccountBody(account: _account, colors: _colors),
    );
  }
}
