import 'dart:convert';
import 'package:finora/domain/validators/money_validator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/value_object/money.dart';
import 'package:finora/domain/exception/empty_value_exception.dart';
import 'package:finora/domain/exception/invalid_format_exception.dart';
import 'package:finora/domain/exception/invalid_amount_exception.dart';

void main() {
  group('🛡️ Account & Money Core Domain - Comprehensive Robustness Suite', () {
    group('A. Money Value Object Invariants', () {
      test(
        'Success: should create Money with valid decimal and integer boundaries',
        () {
          final zeroMoney = Money.create(value: 0.0, exclusiveZero: false);
          final hugeMoney = Money.create(value: 99999999.99);
          expect(zeroMoney.value, equals(0.0));
          expect(hugeMoney.value, equals(99999999.99));
          expect(hugeMoney.toString(), equals('99999999.99'));
        },
      );
      test(
        'Failure: should throw InvalidAmountException on negative money values',
        () {
          expect(
            () => Money.create(value: -0.0001),
            throwsA(isA<InvalidAmountException>()),
          );
          expect(
            () => Money.create(value: -1500.0),
            throwsA(isA<InvalidAmountException>()),
          );
        },
      );
      test(
        'Failure: should throw InvalidAmountException on NaN or Infinite floating points',
        () {
          expect(
            () => MoneyValidator.validateOrThrow(amount: double.nan),
            throwsA(isA<InvalidAmountException>()),
          );
          expect(
            () => Money.create(value: double.infinity),
            throwsA(isA<InvalidAmountException>()),
          );
        },
      );
      test('Equality: Structural equivalence for Value Objects', () {
        final m1 = Money.create(value: 450.50);
        final m2 = Money.create(value: 450.50);
        final m3 = Money.create(value: 450.51);
        expect(m1, equals(m2));
        expect(m1.hashCode, equals(m2.hashCode));
        expect(m1, isNot(equals(m3)));
      });
    });

    group('B. Account ID Validator Sanitization & Constraints', () {
      test(
        'Sanitization: Should accept valid ID with messy trailing/leading spaces and trim them',
        () {
          // بنبعت ID حواليه مسافات عشوائية عشان نتأكد إن الـ validation بيطهره ويرجعه نظيف
          final account = Account.create(
            id: '   acc_123456   ',
            initialBalance: 100.0,
            createdAt: DateTime.now(),
          );
          expect(account.id, equals('acc_123456'));
        },
      );

      test(
        'Failure: Should throw EmptyValueException if ID is empty or whitespace only',
        () {
          expect(
            () => Account.create(
              id: '',
              initialBalance: 10.0,
              createdAt: DateTime.now(),
            ),
            throwsA(isA<EmptyValueException>()),
          );
          expect(
            () => Account.create(
              id: '     ',
              initialBalance: 10.0,
              createdAt: DateTime.now(),
            ),
            throwsA(isA<EmptyValueException>()),
          );
        },
      );

      test('Failure: Should reject IDs missing the prefix "acc_"', () {
        expect(
          () => Account.create(
            id: '123456',
            initialBalance: 10.0,
            createdAt: DateTime.now(),
          ),
          throwsA(isA<InvalidFormatException>()),
        );
      });

      test(
        'Failure: Should reject IDs with digits exceeding the 10-character limit (1-10 digits)',
        () {
          // 11 رقم بعد الـ acc_
          expect(
            () => Account.create(
              id: 'acc_12345678901',
              initialBalance: 10.0,
              createdAt: DateTime.now(),
            ),
            throwsA(isA<InvalidFormatException>()),
          );
        },
      );

      test(
        'Failure: Should reject IDs containing alphabetic characters or symbols in the numeric suffix',
        () {
          expect(
            () => Account.create(
              id: 'acc_1234a',
              initialBalance: 10.0,
              createdAt: DateTime.now(),
            ),
            throwsA(isA<InvalidFormatException>()),
          );
          expect(
            () => Account.create(
              id: 'acc_12_34',
              initialBalance: 10.0,
              createdAt: DateTime.now(),
            ),
            throwsA(isA<InvalidFormatException>()),
          );
        },
      );
    });

    group('C. Serialization & Deserialization Robustness', () {
      test(
        'Mapping: should convert Account to valid map representing the current state',
        () {
          final account = Account.create(
            id: 'acc_98765',
            initialBalance: 2500.75,
            createdAt: DateTime.now(),
          );
          final map = account.toMap();

          expect(map['id'], equals('acc_98765'));
          expect(map['initialBalance'], equals(2500.75));
        },
      );

      test(
        'JSON: Round-trip JSON Serialization and Deserialization must yield identical domain rules',
        () {
          final original = Account.create(
            id: 'acc_11111',
            initialBalance: 80.0,
            createdAt: DateTime.now(),
          );
          final jsonStr = original.toJson();

          // إعادة البناء من الـ JSON الناتج
          final parsed = Account.fromJson(jsonDecode(jsonStr));

          expect(parsed.id, equals(original.id));
          expect(
            parsed.initialBalance.value,
            equals(original.initialBalance.value),
          );
          expect(
            parsed,
            equals(original),
            reason: 'Identity-based equality must persist',
          );
        },
      );

      test(
        'Robustness: JSON parser must handle integer-to-double implicit conversion',
        () {
          // في الـ JSON، أحياناً الأرقام بتتسيف كـ int (مثال: 50) مش double (50.0)
          // التيست ده بيضمن إن الـ parsed double مش هيعمل crash لو استلم int
          final Map<String, dynamic> rawJson = {
            'id': 'acc_33333',
            'initialBalance': 500,
            'currentBalance': 200,
            "createdAt": DateTime.now().toIso8601String(),
          };

          final account = Account.fromJson(rawJson);
          expect(account.initialBalance.value, equals(500.0));
        },
      );
    });

    group('D. Account Entity Lifecycle & DDD Equality Invariant', () {
      test(
        'Identity Equality: Accounts with same ID are the same entity even if balance changes',
        () {
          final account1 = Account.create(
            id: 'acc_55555',
            initialBalance: 100.0,
            createdAt: DateTime.now(),
          );
          final account2 = Account.create(
            id: 'acc_55555',
            initialBalance: 9999.0,
            createdAt: DateTime.now(),
          );

          expect(
            account1,
            equals(account2),
            reason: 'DDD: Entities are equal by identity (ID)',
          );
          expect(account1.hashCode, equals(account2.hashCode));
        },
      );

      test(
        'Identity Inequality: Accounts with different IDs must not be equal',
        () {
          final account1 = Account.create(
            id: 'acc_111',
            initialBalance: 100.0,
            createdAt: DateTime.now(),
          );
          final account2 = Account.create(
            id: 'acc_222',
            initialBalance: 100.0,
            createdAt: DateTime.now(),
          );

          expect(account1, isNot(equals(account2)));
        },
      );
    });
  });
}
