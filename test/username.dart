import 'package:test/test.dart';
import 'package:finora/domain/value_object/user_name.dart';
import 'package:finora/domain/validators/user_name_validator.dart';
import 'package:finora/domain/services/user_name_generator.dart';
import 'package:finora/domain/exception/empty_value_exception.dart';
import 'package:finora/domain/exception/invalid_format_exception.dart';

void main() {
  group('UserName Value Object & Validator Tests', () {
    // ------------------------------------------------------------------------
    // 1. Happy Paths
    // ------------------------------------------------------------------------
    group('Happy Paths', () {
      test('should create UserName successfully with valid patterns', () {
        final validUsernames = [
          'alex@123',
          'john_1',
          'dev-9999999999',
          'User_007',
          'aBcdEfGkLmNo@1', // 12 letters + symbol + 1 digit
        ];

        for (final input in validUsernames) {
          final userName = UserName.create(value: input);
          expect(userName.value, equals(input));
        }
      });

      test('should trim leading and trailing spaces automatically', () {
        const rawInput = '   alex_123   ';
        final userName = UserName.create(value: rawInput);

        expect(userName.value, equals('alex_123'));
      });
    });

    // ------------------------------------------------------------------------
    // 2. Empty & Whitespace Validation
    // ------------------------------------------------------------------------
    group('Empty Values', () {
      test('should throw EmptyValueException when username is empty', () {
        expect(
          () => UserName.create(value: ''),
          throwsA(isA<EmptyValueException>()),
        );
      });

      test(
        'should throw EmptyValueException when username contains only spaces',
        () {
          expect(
            () => UserName.create(value: '     '),
            throwsA(isA<EmptyValueException>()),
          );
        },
      );
    });

    // ------------------------------------------------------------------------
    // 3. Format Restrictions (Invalid Patterns)
    // ------------------------------------------------------------------------
    group('Invalid Formats', () {
      test(
        'should throw InvalidFormatException when letters count is less than 3',
        () {
          // Only 2 letters
          expect(
            () => UserName.create(value: 'ab@123'),
            throwsA(isA<InvalidFormatException>()),
          );
        },
      );

      test(
        'should throw InvalidFormatException when letters count exceeds 12',
        () {
          // 13 letters
          expect(
            () => UserName.create(value: 'abcdefghijklm@123'),
            throwsA(isA<InvalidFormatException>()),
          );
        },
      );

      test(
        'should throw InvalidFormatException when symbol is missing or illegal',
        () {
          const invalidSymbols = [
            'alex123', // missing symbol
            'alex#123', // illegal symbol #
            'alex.123', // illegal symbol .
            r'alex$123', // illegal symbol $
          ];

          for (final input in invalidSymbols) {
            expect(
              () => UserName.create(value: input),
              throwsA(isA<InvalidFormatException>()),
            );
          }
        },
      );

      test(
        'should throw InvalidFormatException when digits are missing or exceed 10 digits',
        () {
          expect(
            () => UserName.create(value: 'alex@'), // Missing digits
            throwsA(isA<InvalidFormatException>()),
          );

          expect(
            () => UserName.create(
              value: 'alex@12345678901',
            ), // 11 digits (exceeds 10)
            throwsA(isA<InvalidFormatException>()),
          );
        },
      );

      test(
        'should throw InvalidFormatException when format order is violated',
        () {
          expect(
            () => UserName.create(value: '123@alex'), // Digits first
            throwsA(isA<InvalidFormatException>()),
          );
        },
      );
    });

    // ------------------------------------------------------------------------
    // 4. Value Equality & Immutability
    // ------------------------------------------------------------------------
    group('Value Equality', () {
      test(
        'should consider two UserName objects equal if they have the same value',
        () {
          final userName1 = UserName.create(value: 'karim_10');
          final userName2 = UserName.create(value: 'karim_10');

          expect(userName1, equals(userName2));
          expect(userName1.hashCode, equals(userName2.hashCode));
        },
      );

      test('should not equal if values are different', () {
        final userName1 = UserName.create(value: 'karim_10');
        final userName2 = UserName.create(value: 'karim_11');

        expect(userName1, isNot(equals(userName2)));
      });
    });
  });

  // ------------------------------------------------------------------------
  // 5. UserNameGenerator Tests
  // ------------------------------------------------------------------------
  group('UserNameGenerator Tests', () {
    test('should generate valid UserName using input name', () {
      const name = 'Ahmed';
      final generatedUserName = UserNameGenerator.generate(name: name);

      expect(generatedUserName, isA<UserName>());
      expect(generatedUserName.value, startsWith(name));
      // Ensures the generated output adheres to our regex rules via UserName.create
      expect(
        () => UserNameValidator.validateOrThrow(generatedUserName.value),
        returnsNormally,
      );
    });
  });
}
