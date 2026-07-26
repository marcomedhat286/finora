import 'package:flutter_test/flutter_test.dart';
import 'package:finora/domain/value_object/person_name.dart';
import 'package:finora/domain/exception/empty_value_exception.dart';
import 'package:finora/domain/exception/invalid_format_exception.dart';

void main() {
  group('🛡️ PersonName Value Object - Robustness Tests', () {
    group('1. Success Cases (Happy Paths & Boundaries)', () {
      test(
        'Should successfully create a valid name with standard English letters',
        () {
          final name = PersonName.create(value: 'Adel');
          expect(name.value, equals('Adel'));
          expect(name.toString(), equals('Adel'));
        },
      );

      test(
        'Should accept minimal valid name length (Exactly 3 characters)',
        () {
          expect(() => PersonName.create(value: 'Joe'), returnsNormally);
          final name = PersonName.create(value: 'Joe');
          expect(name.value.length, equals(3));
        },
      );

      test(
        'Should accept maximal valid name length (Exactly 12 characters)',
        () {
          const twelveCharName = 'Janemariajoe'; // 12 chars
          expect(
            () => PersonName.create(value: twelveCharName),
            returnsNormally,
          );
          final name = PersonName.create(value: twelveCharName);
          expect(name.value.length, equals(12));
        },
      );

      test(
        'Should successfully trim leading and trailing whitespaces before validation',
        () {
          // بنبعت اسم فيه مسافات عشوائية عشان نضمن إن الـ trim شغال
          final name = PersonName.create(value: '   Mario   ');
          expect(name.value, equals('Mario'), reason: 'Spaces must be trimmed');
          expect(name.value.length, equals(5));
        },
      );
    });

    group('2. Failure Cases (Destructive Validation Check)', () {
      test('Should throw EmptyValueException when name is empty', () {
        expect(
          () => PersonName.create(value: ''),
          throwsA(isA<EmptyValueException>()),
        );
      });

      test(
        'Should throw EmptyValueException when name contains only whitespaces',
        () {
          expect(
            () => PersonName.create(value: '     '),
            throwsA(isA<EmptyValueException>()),
          );
        },
      );

      test(
        'Should throw InvalidFormatException when name is too short (less than 3 chars)',
        () {
          expect(
            () => PersonName.create(value: 'Ed'),
            throwsA(isA<InvalidFormatException>()),
          );
        },
      );

      test(
        'Should throw InvalidFormatException when name is too long (greater than 12 chars)',
        () {
          expect(
            () => PersonName.create(value: 'Abcdefghijklm'), // 13 chars
            throwsA(isA<InvalidFormatException>()),
          );
        },
      );

      test('Should throw InvalidFormatException if name contains numbers', () {
        expect(
          () => PersonName.create(value: 'Adel123'),
          throwsA(isA<InvalidFormatException>()),
        );
      });

      test(
        'Should throw InvalidFormatException if name contains special characters',
        () {
          expect(
            () => PersonName.create(value: 'Adel_'),
            throwsA(isA<InvalidFormatException>()),
          );
          expect(
            () => PersonName.create(
              value: 'John-Doe',
            ), // Names shouldn't contain dashes in our regex
            throwsA(isA<InvalidFormatException>()),
          );
        },
      );

      test('Should dynamically use custom nameType in exception message', () {
        expect(
          () => PersonName.create(value: '', nameType: 'last name'),
          throwsA(
            isA<EmptyValueException>().having(
              (e) => e.toString(),
              'exception message',
              contains('The last name must not be empty.'),
            ),
          ),
        );
      });
    });

    group('3. Value Object Equality (DDD Invariants)', () {
      test(
        'Two different instances with the exact same value should be equal',
        () {
          final name1 = PersonName.create(value: 'Youssef');
          final name2 = PersonName.create(value: 'Youssef');
          final differentName = PersonName.create(value: 'Mina');

          expect(name1, equals(name2)); // مقارنة قيم
          expect(name1.hashCode, equals(name2.hashCode)); // تطابق الـ HashCode
          expect(name1, isNot(equals(differentName)));
        },
      );

      test(
        'Equality should still hold true even if original values had different trailing spaces',
        () {
          final name1 = PersonName.create(value: 'Amr   ');
          final name2 = PersonName.create(value: '   Amr');

          expect(
            name1,
            equals(name2),
            reason: 'Sanitized values should be equal',
          );
        },
      );
    });
  });
}
