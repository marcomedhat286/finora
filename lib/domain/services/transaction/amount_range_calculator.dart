import 'package:finora/domain/enum/transaction/amount_range_option.dart';
import 'package:finora/domain/value_object/transaction/amount_range.dart';

abstract final class AmountRangeCalculator {
  static AmountRange? calculate(AmountRangeOptions option) {
    switch (option) {
      case AmountRangeOptions.any:
        return null;

      case AmountRangeOptions.from1to50:
        return AmountRange.create(min: 1, max: 50);

      case AmountRangeOptions.from50to200:
        return AmountRange.create(min: 50, max: 200);

      case AmountRangeOptions.from200to500:
        return AmountRange.create(min: 200, max: 500);

      case AmountRangeOptions.moreThan500:
        return AmountRange.create(min: 500);
    }
  }
}
