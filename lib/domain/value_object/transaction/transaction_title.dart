import 'package:finora/domain/validators/transactoin/title_validator.dart';

class TransactionTitle {
  final String value;

  const TransactionTitle._(this.value);

  factory TransactionTitle.create(String rawTitle) {
    final cleanedTitle = TitleValidator.validateOrThrow(title: rawTitle);
    return TransactionTitle._(cleanedTitle);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionTitle &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
