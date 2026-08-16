import 'package:finora/domain/exception/empty_value_exception.dart';
import 'package:finora/core/utils/parse/money_input_parser.dart';
import 'package:finora/domain/validators/invalid_double_format_exception.dart';
import 'package:test/test.dart';

void main() {
  group('MoneyInputParser Tests', () {
    test('should parse valid integer string to double successfully', () {
      final result = MoneyInputParser.parseToDouble(
        value: '2000',
        fieldName: 'Balance',
      );

      expect(result, equals(2000.0));
    });

    test('should parse valid decimal string to double successfully', () {
      final result = MoneyInputParser.parseToDouble(
        value: '150.75',
        fieldName: 'Balance',
      );

      expect(result, equals(150.75));
    });

    test('should handle string with leading and trailing spaces correctly', () {
      final result = MoneyInputParser.parseToDouble(
        value: '   500.50   ',
        fieldName: 'Balance',
      );

      expect(result, equals(500.50));
    });

    test('should throw EmptyValueException when input string is empty', () {
      expect(
        () => MoneyInputParser.parseToDouble(
          value: '',
          fieldName: 'Initial Balance',
        ),
        throwsA(
          isA<EmptyValueException>().having(
            (e) => e.message,
            'message',
            contains('Initial Balance must not be empty'),
          ),
        ),
      );
    });

    test(
      'should throw EmptyValueException when input string is only whitespace',
      () {
        expect(
          () => MoneyInputParser.parseToDouble(
            value: '     ',
            fieldName: 'Initial Balance',
          ),
          throwsA(isA<EmptyValueException>()),
        );
      },
    );

    test(
      'should throw InvalidDoubleFormatException when string contains letters or invalid characters',
      () {
        expect(
          () => MoneyInputParser.parseToDouble(
            value: '2000abc',
            fieldName: 'Balance',
          ),
          throwsA(isA<InvalidDoubleFormatException>()),
        );
      },
    );

    test(
      'should throw InvalidDoubleFormatException for multiple decimal points',
      () {
        expect(
          () => MoneyInputParser.parseToDouble(
            value: '10.50.25',
            fieldName: 'Balance',
          ),
          throwsA(isA<InvalidDoubleFormatException>()),
        );
      },
    );
  });
}
