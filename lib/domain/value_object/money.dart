import 'package:finora/domain/validators/money_validator.dart';

class Money {
  final double value;

  const Money._({required this.value});

  factory Money.create({required double value, bool exclusiveZero = true}) {
    final roundedValue = double.parse(value.toStringAsFixed(2));
    MoneyValidator.validateOrThrow(
      amount: roundedValue,
      exclusiveZero: exclusiveZero,
    );

    return Money._(value: roundedValue);
  }

  Money operator +(Money other) =>
      Money.create(value: value + other.value, exclusiveZero: false);
  Money operator -(Money other) =>
      Money.create(value: value - other.value, exclusiveZero: false);
  bool get isZero => value == 0;

  @override
  String toString() => value.toStringAsFixed(2);

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other is Money && other.value == value);
  }

  @override
  int get hashCode => value.hashCode;
}
