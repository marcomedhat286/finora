import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

abstract interface class TransactionCategoryType {
  String get code;
  String get displayName;
  FaIconData get icon;
  Color get iconColor;
}
