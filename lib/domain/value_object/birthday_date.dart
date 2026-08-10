import 'package:finora/domain/validators/birthdate_validator.dart';

class BirthdayDate {
  final DateTime value;
  const BirthdayDate._({required this.value});

  factory BirthdayDate.create(DateTime? date) {
    final validDate = BirthdateValidator.validateOrThrow(date);
    return BirthdayDate._(value: validDate);
  }
  int get age {
    final now = DateTime.now();
    return now.year -
        value.year -
        ((now.month < value.month ||
                (now.month == value.month && now.day < value.day))
            ? 1
            : 0);
  }

  String get formattedDate => "${value.day}/${value.month}/${value.year}";
}
