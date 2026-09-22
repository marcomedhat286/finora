import 'package:finora/domain/enum/transaction/transaction_category_type.dart';
import 'package:finora/presentation/extensions/category_ui_extension.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionIcon extends StatelessWidget {
  const TransactionIcon({super.key, required this._categoryType});

  final TransactionCategoryType _categoryType;

  @override
  Widget build(BuildContext context) {
    const double fullRadiusCricle = 175;
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: SizedBox(
        height: fullRadiusCricle,
        width: fullRadiusCricle,
        child: CircleAvatar(
          backgroundColor: Colors.grey.withAlpha(50),
          child: FaIcon(
            _categoryType.icon,
            color: _categoryType.iconColor,
            size: fullRadiusCricle / 2,
          ),
        ),
      ),
    );
  }
}
