import 'package:finora/domain/services/user_name_generator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finora/domain/services/random_digits_generator.dart';

import 'package:finora/domain/validators/user_name_validator.dart';
import 'package:finora/domain/value_object/user_name.dart';
import 'package:finora/domain/exception/empty_value_exception.dart';
import 'package:finora/domain/exception/invalid_format_exception.dart';

void main() {
  group('🛡️ 1. RandomDigitsGenerator Robustness Tests', () {
    test('Should generate varying lengths of digits between 1 and 10', () {
      final generatedNumbers = <String>{};
      // بنجرب نولد رقم 100 مرة للتأكد من عشوائية الطول وعدم تخطي الحدود
      for (var i = 0; i < 100; i++) {
        final number = RandomDigitsGenerator.generate();
        expect(number, isNotEmpty);
        expect(number.length, lessThanOrEqualTo(10));
        expect(number.length, greaterThanOrEqualTo(1));
        expect(
          RegExp(r'^\d+$').hasMatch(number),
          isTrue,
          reason: "Must contain digits only",
        );
        generatedNumbers.add(number);
      }
      // نتأكد إن الأرقام بتتغير فعلاً ومش ثابتة
      expect(
        generatedNumbers.length,
        greaterThanOrEqualTo(90),
        reason: "Entropy should generate highly unique sequences ",
      );
    });
  });

  group('🛡️ 2. UserNameValidator Boundary & Edge Case Tests', () {
    group('Success Cases (Boundary Check)', () {
      test(
        'Should accept minimal name part (3 chars) + separator + minimal digits (1 char)',
        () {
          expect(
            () => UserNameValidator.validateOrThrow('abc_1'),
            returnsNormally,
          );
        },
      );
      test(
        'Should accept maximal name part (12 chars) + separator + maximal digits (10 chars)',
        () {
          expect(
            () => UserNameValidator.validateOrThrow('abcdefghijkl-1234567890'),
            returnsNormally,
          );
        },
      );
      test('Should accept all valid separators (@, _, -)', () {
        expect(
          () => UserNameValidator.validateOrThrow('username@123'),
          returnsNormally,
        );
        expect(
          () => UserNameValidator.validateOrThrow('username_123'),
          returnsNormally,
        );
        expect(
          () => UserNameValidator.validateOrThrow('username-123'),
          returnsNormally,
        );
      });
    });

    group('Failure Cases (Destructive Testing)', () {
      test(
        'Should throw EmptyValueException when empty or whitespaces only',
        () {
          expect(
            () => UserNameValidator.validateOrThrow(''),
            throwsA(isA<EmptyValueException>()),
          );
          expect(
            () => UserNameValidator.validateOrThrow('   '),
            throwsA(isA<EmptyValueException>()),
          );
        },
      );

      test(
        'Should throw InvalidFormatException when name part is too short (less than 3 chars)',
        () {
          expect(
            () => UserNameValidator.validateOrThrow('ab_1'),
            throwsA(isA<InvalidFormatException>()),
          );
        },
      );

      test(
        'Should throw InvalidFormatException when name part is too long (greater than 12 chars)',
        () {
          expect(
            () => UserNameValidator.validateOrThrow(
              'abcdefghijklm_1',
            ), // 13 letters
            throwsA(isA<InvalidFormatException>()),
          );
        },
      );

      test(
        'Should throw InvalidFormatException if name contains numbers or special chars before separator',
        () {
          expect(
            () => UserNameValidator.validateOrThrow('john1_123'),
            throwsA(isA<InvalidFormatException>()),
          );
          expect(
            () => UserNameValidator.validateOrThrow('jo\$hn_123'),
            throwsA(isA<InvalidFormatException>()),
          );
        },
      );

      test(
        'Should throw InvalidFormatException for Arabic/Non-English letters',
        () {
          expect(
            () => UserNameValidator.validateOrThrow('أحمد_123'),
            throwsA(isA<InvalidFormatException>()),
          );
        },
      );

      test(
        'Should throw InvalidFormatException if separator is missing or duplicated',
        () {
          expect(
            () => UserNameValidator.validateOrThrow(
              'username123',
            ), // missing separator
            throwsA(isA<InvalidFormatException>()),
          );
          expect(
            () => UserNameValidator.validateOrThrow(
              'username__123',
            ), // duplicated separator
            throwsA(isA<InvalidFormatException>()),
          );
          expect(
            () => UserNameValidator.validateOrThrow(
              'user_name_123',
            ), // multiple separators
            throwsA(isA<InvalidFormatException>()),
          );
        },
      );

      test(
        'Should throw InvalidFormatException if digits part is missing or too long',
        () {
          expect(
            () => UserNameValidator.validateOrThrow(
              'username_',
            ), // missing digits
            throwsA(isA<InvalidFormatException>()),
          );
          expect(
            () => UserNameValidator.validateOrThrow(
              'username_12345678901',
            ), // 11 digits (max is 10)
            throwsA(isA<InvalidFormatException>()),
          );
        },
      );
    });
  });

  group('🛡️ 3. UserName Generator Integration Tests', () {
    test(
      'Should generate a perfectly formatted UserName from valid given name',
      () {
        final usernameVo = UserNameGenerator.generateUserName(name: 'Adel');

        expect(usernameVo, isA<UserName>());
        expect(usernameVo.value, startsWith('Adel'));

        // نتأكد إن المولد التزم بالـ regex اللي في الـ Validator
        expect(
          () => UserNameValidator.validateOrThrow(usernameVo.value),
          returnsNormally,
        );
      },
    );

    test(
      'Should throw exception during generation if the seed name itself is invalid',
      () {
        expect(
          () => UserNameGenerator.generateUserName(name: 'A1'), // اسم تالف
          throwsA(isA<InvalidFormatException>()),
        );
      },
    );
  });

  group('🛡️ 4. UserName Value Object Domain Invariants', () {
    test(
      'Should enforce Value-Based Equality (Two instances with same value must be equal)',
      () {
        final user1 = UserName.create(value: 'mario_123');
        final user2 = UserName.create(value: 'mario_123');
        final user3 = UserName.create(value: 'luigi_123');

        expect(user1, equals(user2));
        expect(user1.hashCode, equals(user2.hashCode));
        expect(user1, isNot(equals(user3)));
      },
    );

    test('ToString override should return the raw value directly', () {
      final username = UserName.create(value: 'youssef-99');
      expect(username.toString(), 'youssef-99');
    });
    test('equal override should return if two is equal', () {
      final username = UserName.create(value: 'youssef-99');
      final username2 = UserName.create(value: 'youssef_99');
      expect(username2 == username, false);
    });
  });
}
