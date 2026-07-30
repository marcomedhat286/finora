import 'package:finora/domain/exception/empty_value_exception.dart';
import 'package:finora/domain/exception/invalid_converting_double.dart';

class ConvertStringTodoubleBalance {
  static double convert({required String value, required String valueName}) {
    if (value.isEmpty) {
      throw EmptyValueException("The $valueName must not be empty.");
    }
    try {
      return double.parse(value);
    } catch (e) {
      throw const InvalidConvertingDouble("The value must be numbers eg. 2000");
    }
  }
}
