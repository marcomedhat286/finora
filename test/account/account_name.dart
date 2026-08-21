import 'package:finora/domain/exception/empty_value_exception.dart';
import 'package:finora/domain/exception/invalid_account_name_length_exception.dart';
import 'package:finora/domain/value_object/account_name.dart';
import 'package:test/test.dart';

void main() {
  group('AccountName & AccountNameValidator Tests', () {
    const validName = 'Main bank account';

    group('Creation & Validation Success Cases', () {
      test('should create AccountName successfully with valid input', () {
        final accountName = AccountName.create(validName);

        expect(accountName.value, equals(validName));
      });

      test('should trim leading and trailing whitespace correctly', () {
        final accountName = AccountName.create('   Smart Wallet  ');

        expect(accountName.value, equals('Smart Wallet'));
      });

      test('should accept name with minimum valid length (2 characters)', () {
        final accountName = AccountName.create('Cash');

        expect(accountName.value, equals('Cash'));
      });

      test('should accept name with maximum valid length (30 characters)', () {
        final thirtyCharName = 'a' * 30;
        final accountName = AccountName.create(thirtyCharName);

        expect(accountName.value, equals(thirtyCharName));
      });
    });

    group('Validation Failure Cases', () {
      test('should throw EmptyValueException when input string is empty', () {
        expect(
          () => AccountName.create(''),
          throwsA(
            isA<EmptyValueException>().having(
              (e) => e.message,
              'message',
              contains('name must not be empty'),
            ),
          ),
        );
      });

      test(
        'should throw EmptyValueException when input string is only whitespace',
        () {
          expect(
            () => AccountName.create('      '),
            throwsA(isA<EmptyValueException>()),
          );
        },
      );

      test(
        'should throw InvalidAccountNameLengthException when name is less than 2 characters',
        () {
          expect(
            () => AccountName.create(' a  '),
            throwsA(
              isA<InvalidAccountNameLengthException>().having(
                (e) => e.currentLength,
                'currentLength',
                equals(1),
              ),
            ),
          );
        },
      );

      test(
        'should throw InvalidAccountNameLengthException when name exceeds 30 characters',
        () {
          final thirtyOneCharName = 'a' * 31;

          expect(
            () => AccountName.create(thirtyOneCharName),
            throwsA(
              isA<InvalidAccountNameLengthException>().having(
                (e) => e.currentLength,
                'currentLength',
                equals(31),
              ),
            ),
          );
        },
      );
    });

    group('Value Equality & Behavior', () {
      test(
        'should consider two AccountName instances equal if they have the same value',
        () {
          final name1 = AccountName.create('Savings account');
          final name2 = AccountName.create('Savings account');

          expect(name1, equals(name2));
          expect(name1.hashCode, equals(name2.hashCode));
        },
      );

      test(
        'should not consider two AccountName instances equal if their values differ',
        () {
          final name1 = AccountName.create('Cash');
          final name2 = AccountName.create('Bank');

          expect(name1, isNot(equals(name2)));
        },
      );

      test('toString should return the internal string value', () {
        final accountName = AccountName.create(validName);

        expect(accountName.toString(), equals(validName));
      });
    });
  });
}
