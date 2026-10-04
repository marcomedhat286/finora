import 'package:finora/domain/validators/transaction/date_range_validator.dart';

final class DateRange {
  static final now = DateTime.now();
  final DateTime? from;
  final DateTime to;

  DateRange._({required this.from, required this.to});

  factory DateRange.create({required DateTime? from, required DateTime to}) {
    if (from == null) {
      return DateRange._(from: null, to: to);
    }
    DateRangeValidator.validateOrThrow(from: from, to: to);
    return DateRange._(from: from, to: to);
  }
}
