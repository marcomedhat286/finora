import 'package:finora/domain/enum/account_type.dart';
import 'package:finora/domain/exception/invalid_account_type_exception.dart';
import 'package:finora/domain/validators/account_type_validator.dart';
import 'package:test/test.dart';

void main() {
  group('AccountType & AccountTypeValidator Tests', () {
    group('Parsing & Validation Success Cases', () {
      test('should parse valid codes correctly using factory constructor', () {
        expect(AccountType.fromCode('bank'), equals(AccountType.bank));
        expect(AccountType.fromCode('cash'), equals(AccountType.cash));
        expect(
          AccountType.fromCode('credit_card'),
          equals(AccountType.creditCard),
        );
        expect(AccountType.fromCode('savings'), equals(AccountType.savings));
        expect(
          AccountType.fromCode('investment'),
          equals(AccountType.investment),
        );
      });

      test('should parse correctly directly from AccountTypeValidator', () {
        final result = AccountTypeValidator.validateAndParse('bank');

        expect(result, equals(AccountType.bank));
      });

      test(
        'should handle leading/trailing whitespaces and uppercase letters',
        () {
          expect(AccountType.fromCode('   BANK   '), equals(AccountType.bank));
          expect(
            AccountType.fromCode('Credit_Card'),
            equals(AccountType.creditCard),
          );
          expect(AccountType.fromCode('  CASH '), equals(AccountType.cash));
        },
      );

      test('toString should return display name', () {
        expect(AccountType.bank.toString(), equals('Bank'));
        expect(AccountType.creditCard.toString(), equals('Credit Card'));
      });
    });

    group('Parsing Failure Cases', () {
      test(
        'should throw InvalidAccountTypeException for unknown or unsupported code',
        () {
          expect(
            () => AccountType.fromCode('crypto'),
            throwsA(
              isA<InvalidAccountTypeException>().having(
                (e) => e.invalidCode,
                'invalidCode',
                equals('crypto'),
              ),
            ),
          );
        },
      );

      test(
        'should throw InvalidAccountTypeException when code is empty or spaces',
        () {
          expect(
            () => AccountType.fromCode(''),
            throwsA(isA<InvalidAccountTypeException>()),
          );

          expect(
            () => AccountType.fromCode('   '),
            throwsA(isA<InvalidAccountTypeException>()),
          );
        },
      );
    });

    group('Type Immutability & Enum Safety Proofs', () {
      test('should contain exactly the predefined set of types', () {
        expect(AccountType.values.length, equals(5));
        expect(
          AccountType.values,
          containsAll([
            AccountType.bank,
            AccountType.cash,
            AccountType.creditCard,
            AccountType.savings,
            AccountType.investment,
          ]),
        );
      });

      test(
        'should verify enum constructor cannot be instantiated dynamically',
        () {
          // 💡 إثبات المعمارية: الكود التالي لو شيلت من عليه التعليق هيرفض الـ Compiler يعمل Build أساساً!
          // AccountType('crypto', 'Cryptocurrency');
          // Error: The enum 'AccountType' can't be instantiated.

          // التأكيد أن القيمة المجهولة تترجم لاستثناء دائماً
          expect(
            () => AccountType.fromCode('crypto'),
            throwsA(isA<InvalidAccountTypeException>()),
          );
        },
      );
    });
  });
}
