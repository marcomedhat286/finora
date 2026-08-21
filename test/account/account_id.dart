import 'package:finora/domain/exception/empty_value_exception.dart';
import 'package:finora/domain/exception/invalid_format_exception.dart';
import 'package:finora/domain/services/account_id_generator.dart';
import 'package:finora/domain/validators/account_id_validator.dart';
import 'package:finora/domain/value_object/account_id.dart';
import 'package:test/test.dart';

void main() {
  group('AccountId & AccountIdValidator Tests', () {
    const validRawId = 'acc_123e4567-e89b-42d3-a456-426614174000';

    group('Creation & Validation', () {
      test(
        'should create AccountId successfully when string format is a valid prefixed UUID v4',
        () {
          final accountId = AccountId.fromUniqueString(validRawId);

          expect(accountId.value, equals(validRawId));
        },
      );

      test('should trim leading and trailing spaces and set clean value', () {
        final accountId = AccountId.fromUniqueString('   $validRawId   ');

        expect(accountId.value, equals(validRawId));
      });

      test('should throw EmptyValueException when raw string is empty', () {
        expect(
          () => AccountId.fromUniqueString(''),
          throwsA(
            isA<EmptyValueException>().having(
              (e) => e.message,
              'message',
              contains('must not be empty'),
            ),
          ),
        );
      });

      test(
        'should throw EmptyValueException when raw string contains only spaces',
        () {
          expect(
            () => AccountId.fromUniqueString('      '),
            throwsA(isA<EmptyValueException>()),
          );
        },
      );

      test(
        'should throw InvalidFormatException when prefix "acc_" is missing',
        () {
          const rawUuidWithoutPrefix = '123e4567-e89b-42d3-a456-426614174000';

          expect(
            () => AccountId.fromUniqueString(rawUuidWithoutPrefix),
            throwsA(isA<InvalidFormatException>()),
          );
        },
      );

      test('should throw InvalidFormatException when UUID part is invalid', () {
        const invalidUuidFormat = 'acc_invalid-uuid-format-1234';

        expect(
          () => AccountId.fromUniqueString(invalidUuidFormat),
          throwsA(isA<InvalidFormatException>()),
        );
      });
    });

    group('Value Equality', () {
      test(
        'should consider two AccountId objects equal if they hold the same value',
        () {
          final id1 = AccountId.fromUniqueString(validRawId);
          final id2 = AccountId.fromUniqueString(validRawId);

          expect(id1, equals(id2));
          expect(id1.hashCode, equals(id2.hashCode));
        },
      );

      test(
        'should not consider two AccountId objects equal if their values differ',
        () {
          final id1 = AccountIdGenerator.generateAccountId();
          final id2 = AccountIdGenerator.generateAccountId();

          expect(id1, isNot(equals(id2)));
        },
      );

      test('toString should return the internal string value', () {
        final accountId = AccountId.fromUniqueString(validRawId);

        expect(accountId.toString(), equals(validRawId));
      });
    });

    group('AccountIdGenerator', () {
      test(
        'should generate a valid AccountId with "acc_" prefix and valid UUID v4',
        () {
          final generatedId = AccountIdGenerator.generateAccountId();

          expect(generatedId.value, startsWith('acc_'));
          expect(
            () => AccountIdValidator.validateOrThrow(generatedId.value),
            returnsNormally,
          );
        },
      );

      test('should generate unique AccountIds on consecutive calls', () {
        final id1 = AccountIdGenerator.generateAccountId();
        final id2 = AccountIdGenerator.generateAccountId();

        expect(id1, isNot(equals(id2)));
      });
    });
  });
}
