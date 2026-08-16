import 'package:finora/domain/validators/account_id_validator.dart';

class AccountId {
  final String _value;

  const AccountId._(this._value);

  factory AccountId.fromUniqueString(String id) {
    final cleanedId = AccountIdValidator.validateOrThrow(id);
    return AccountId._(cleanedId);
  }

  String get value => _value;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AccountId && other._value == _value);
  }

  @override
  int get hashCode => _value.hashCode;

  @override
  String toString() => _value;
}
