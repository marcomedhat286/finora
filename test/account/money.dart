import 'package:test/test.dart';
import 'package:finora/domain/value_object/money.dart';
import 'package:finora/domain/exception/invalid_amount_exception.dart';

void main() {
  group('Money Value Object & Validator Tests', () {
    // ------------------------------------------------------------------------
    // 1. Happy Paths
    // ------------------------------------------------------------------------
    group('Happy Paths', () {
      test(
        'should create Money successfully and round to 2 decimal places',
        () {
          final money = Money.create(value: 100.556);
          expect(money.value, equals(100.56));
          expect(money.toString(), equals('100.56'));
        },
      );

      test('should allow zero when inclusiveZero is true', () {
        final money = Money.create(value: 0.0, inclusiveZero: true);
        expect(money.value, equals(0.0));
        expect(money.isZero, isTrue);
      });
    });

    // ------------------------------------------------------------------------
    // 2. Invalid Amounts & Validation Errors
    // ------------------------------------------------------------------------
    group('Invalid Amounts', () {
      test('should throw InvalidAmountException when amount is negative', () {
        expect(
          () => Money.create(value: -15.5),
          throwsA(isA<InvalidAmountException>()),
        );
      });

      test(
        'should throw InvalidAmountException when zero is passed with inclusiveZero = false',
        () {
          expect(
            () => Money.create(value: 0.0, inclusiveZero: false),
            throwsA(isA<InvalidAmountException>()),
          );
        },
      );

      test(
        'should throw InvalidAmountException for NaN or Infinite values',
        () {
          expect(
            () => Money.create(value: double.nan),
            throwsA(isA<InvalidAmountException>()),
          );

          expect(
            () => Money.create(value: double.infinity),
            throwsA(isA<InvalidAmountException>()),
          );
        },
      );
    });

    // ------------------------------------------------------------------------
    // 3. Operators (+ & -)
    // ------------------------------------------------------------------------
    group('Arithmetic Operators', () {
      test('should add two Money objects correctly', () {
        final m1 = Money.create(value: 50.25);
        final m2 = Money.create(value: 20.75);
        final result = m1 + m2;

        expect(result.value, equals(71.00));
      });

      test('should subtract two Money objects correctly', () {
        final m1 = Money.create(value: 50.00);
        final m2 = Money.create(value: 20.00);
        final result = m1 - m2;

        expect(result.value, equals(30.00));
      });

      test(
        'should subtract two Money objects correctly and throw InvalidAmountException because the result is negative',
        () {
          final m1 = Money.create(value: 50.00);
          final m2 = Money.create(value: 20.00);

          expect(() => m2 - m1, throwsA(isA<InvalidAmountException>()));
        },
      );

      test('should allow zero as result of subtraction', () {
        final m1 = Money.create(value: 50.00);
        final m2 = Money.create(value: 50.00);
        final result = m1 - m2;

        expect(result.value, equals(0.0));
        expect(result.isZero, isTrue);
      });
    });

    // ------------------------------------------------------------------------
    // 4. Value Equality
    // ------------------------------------------------------------------------
    group('Value Equality', () {
      test('should consider two Money objects with same value equal', () {
        final m1 = Money.create(value: 100.0);
        final m2 = Money.create(value: 100.0);

        expect(m1, equals(m2));
        expect(m1.hashCode, equals(m2.hashCode));
      });
    });
  });
}
