import 'package:finora/domain/validators/account/money_validator.dart';

final class AmountRange {
  final double? min;
  final double? max;
  const AmountRange._({this.min, this.max});
  factory AmountRange.create({double? min, double? max}) {
    if (min != null) {
      MoneyValidator.validateOrThrow(
        amount: min,
        inclusiveZero: false,
        feildName: "Min Amount",
      );
      if (max != null) {
        MoneyValidator.validateOrThrow(
          amount: max,
          inclusiveZero: false,
          feildName: "Max Amount",
        );

        if (max < min) {
          throw ArgumentError(
            'Maximum amount cannot be less than minimum amount.',
          );
        }
        return AmountRange._(min: min, max: max);
      } else {
        return AmountRange._(min: min);
      }
    } else {
      if (max != null) {
        MoneyValidator.validateOrThrow(
          amount: max,
          inclusiveZero: false,
          feildName: "Max Amount",
        );
        return AmountRange._(max: max);
      } else {
        return AmountRange._();
      }
    }
  }
}
