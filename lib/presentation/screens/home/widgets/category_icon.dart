import 'package:finora/core/constants.dart';
import 'package:finora/domain/enum/transaction/transaction_category_type.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:finora/presentation/extensions/category_transaction_ui_extension.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({super.key, required this._category});

  final TransactionCategoryType _category;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: radiusIcon,
      height: radiusIcon,
      decoration: BoxDecoration(
        color: _category.iconColor.withAlpha(50),
        shape: BoxShape.circle,
      ),
      child: FaIcon(_category.icon, color: _category.iconColor),
    );
  }
}
