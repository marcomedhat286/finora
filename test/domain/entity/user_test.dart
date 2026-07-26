import 'package:flutter_test/flutter_test.dart';
import 'package:finora/domain/entities/user.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/value_object/user_name.dart';

import 'package:finora/domain/exception/empty_value_exception.dart';
import 'package:finora/domain/exception/invalid_format_exception.dart';

void main() {
  group('🛡️ User Aggregate Root - Enterprise Robustness Suite', () {
    // تجهيز بيانات ثابتة للتيستات
    late UserName defaultUserName;
    late Account defaultAccount;
    late DateTime defaultCreatedAt;

    setUp(() {
      defaultUserName = UserName.create(value: 'mali_2026');
      defaultAccount = Account.create(
        id: 'acc_123456',
        initialBalance: 1500.0,
        createdAt: DateTime.now(),
      );
      defaultCreatedAt = DateTime.now();
    });

    group('A. User Creation & Optional Fields Permutations', () {
      test('Success: should create User with only required fields', () {
        final user = User.create(
          userName: defaultUserName,
          firstName: 'Mohamed',
          account: defaultAccount,
          createdAt: defaultCreatedAt,
        );

        expect(user.userName, equals(defaultUserName));
        expect(user.firstName.value, equals('Mohamed'));
        expect(user.middleName, isNull);
        expect(user.lastName, isNull);
        expect(user.fullName, equals('Mohamed')); // بدون مسافات زائدة
      });

      test(
        'Success: should create User with all fields (First, Middle, Last)',
        () {
          final user = User.create(
            userName: defaultUserName,
            firstName: 'Mohamed',
            middleName: 'Ali',
            lastName: 'Mostafa',
            account: defaultAccount,
            createdAt: defaultCreatedAt,
          );

          expect(user.firstName.value, equals('Mohamed'));
          expect(user.middleName?.value, equals('Ali'));
          expect(user.lastName?.value, equals('Mostafa'));
          expect(user.fullName, equals('Mohamed Ali Mostafa'));
        },
      );

      test(
        'Success: should create User with First and Last name only (No Middle)',
        () {
          final user = User.create(
            userName: defaultUserName,
            firstName: 'Mohamed',
            lastName: 'Mostafa',
            account: defaultAccount,
            createdAt: defaultCreatedAt,
          );

          expect(user.middleName, isNull);
          expect(
            user.fullName,
            equals('Mohamed Mostafa'),
          ); // ذكي: مسافة واحدة في المنتصف
        },
      );

      test(
        'Success: should create User with First and Middle name only (No Last)',
        () {
          final user = User.create(
            userName: defaultUserName,
            firstName: 'Mohamed',
            middleName: 'Ali',
            account: defaultAccount,
            createdAt: defaultCreatedAt,
          );

          expect(user.lastName, isNull);
          expect(user.fullName, equals('Mohamed Ali'));
        },
      );
    });

    group('B. Domain Invariants Validation Constraints', () {
      test(
        'Failure: should throw EmptyValueException if firstName is empty',
        () {
          expect(
            () => User.create(
              userName: defaultUserName,
              firstName: '   ',
              account: defaultAccount,
              createdAt: defaultCreatedAt,
            ),
            throwsA(isA<EmptyValueException>()),
          );
        },
      );

      test(
        'Failure: should throw InvalidFormatException if middleName violates naming rules',
        () {
          expect(
            () => User.create(
              userName: defaultUserName,
              firstName: 'Mohamed',
              middleName: 'Ali123', // يحتوي على أرقام
              account: defaultAccount,
              createdAt: defaultCreatedAt,
            ),
            throwsA(isA<InvalidFormatException>()),
          );
        },
      );

      test('Failure: should throw Exception if createdAt is in the future', () {
        final futureDate = DateTime.now().add(const Duration(days: 1));
        expect(
          () => User.create(
            userName: defaultUserName,
            firstName: 'Mohamed',
            account: defaultAccount,
            createdAt: futureDate, // تاريخ في المستقبل البعيد غير منطقي
          ),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('C. copyWith & Sentinel Pattern Robustness', () {
      late User originalUser;

      setUp(() {
        originalUser = User.create(
          userName: defaultUserName,
          firstName: 'Mohamed',
          middleName: 'Ali',
          lastName: 'Mostafa',
          account: defaultAccount,
          createdAt: defaultCreatedAt,
        );
      });

      test(
        'No Change: calling copyWith with empty parameters should keep original values',
        () {
          final updated = originalUser.copyWith();

          expect(updated.userName, equals(originalUser.userName));
          expect(updated.firstName.value, equals(originalUser.firstName.value));
          expect(
            updated.middleName?.value,
            equals(originalUser.middleName?.value),
          );
          expect(updated.lastName?.value, equals(originalUser.lastName?.value));
        },
      );

      test(
        'Modify: should update non-optional and optional fields correctly',
        () {
          final newUserName = UserName.create(value: 'newusername_99');
          final updated = originalUser.copyWith(
            userName: newUserName,
            firstName: 'Ahmed',
          );

          expect(updated.userName, equals(newUserName));
          expect(updated.firstName.value, equals('Ahmed'));
          // لم يتم لمسهم في الـ parameters، لازم يفضلوا زي ما هما من الكائن الأصلي
          expect(updated.middleName?.value, equals('Ali'));
          expect(updated.lastName?.value, equals('Mostafa'));
        },
      );

      test(
        'Clear to Null: should set optional fields to null using sentinel bypass',
        () {
          // بنمرر null صريح عشان نمسح الـ middleName والـ lastName
          final updated = originalUser.copyWith(
            middleName: null,
            lastName: null,
          );

          expect(updated.middleName, isNull);
          expect(updated.lastName, isNull);
          expect(
            updated.fullName,
            equals('Mohamed'),
          ); // الاسم الكامل يتحدث ديناميكياً
        },
      );
    });

    group('D. Serialization and Deep Object Restoration', () {
      test(
        'Mapping: toMap should produce exact serializable structure with nested objects',
        () {
          final user = User.create(
            userName: defaultUserName,
            firstName: 'Mohamed',
            middleName: 'Ali',
            account: defaultAccount,
            createdAt: defaultCreatedAt,
          );

          final map = user.toMap();

          expect(map['userName'], equals('mali_2026'));
          expect(map['firstName'], equals('Mohamed'));
          expect(map['middleName'], equals('Ali'));
          expect(map['lastName'], isNull);
          expect(map['account'], isA<Map<String, dynamic>>());
          expect(map['account']['id'], equals('acc_123456'));
          expect(map['createdAt'], equals(defaultCreatedAt.toIso8601String()));
        },
      );

      test(
        'JSON Roundtrip: fromJson must successfully parse and recreate the aggregate structure',
        () {
          final originalUser = User.create(
            userName: defaultUserName,
            firstName: 'Mohamed',
            middleName: 'Ali',
            lastName: 'Mostafa',
            account: defaultAccount,
            createdAt: defaultCreatedAt,
          );

          final rawJsonMap = originalUser.toMap();
          print(rawJsonMap);

          // إعادة البناء من الـ Map
          final restoredUser = User.fromJson(json: rawJsonMap);

          expect(
            restoredUser.userName.value,
            equals(originalUser.userName.value),
          );
          expect(
            restoredUser.firstName.value,
            equals(originalUser.firstName.value),
          );
          expect(
            restoredUser.middleName?.value,
            equals(originalUser.middleName?.value),
          );
          expect(
            restoredUser.lastName?.value,
            equals(originalUser.lastName?.value),
          );
          expect(restoredUser.account.id, equals(originalUser.account.id));
          expect(
            restoredUser.account.initialBalance.value,
            equals(originalUser.account.initialBalance.value),
          );
          expect(
            restoredUser.account.currentBalance.value,
            equals(originalUser.account.currentBalance.value),
          );
          expect(restoredUser.createdAt, equals(originalUser.createdAt));
          expect(
            restoredUser,
            equals(originalUser),
            reason: 'Identity-based equality must persist through restoration',
          );
        },
      );
    });

    group('E. Identity Invariant (DDD Equality)', () {
      test(
        'Identity Equality: Users are equal if they share the same userName, even if other attributes differ',
        () {
          final user1 = User.create(
            userName: defaultUserName,
            firstName: 'Mohamed',
            account: defaultAccount,
            createdAt: defaultCreatedAt,
          );

          final differentAccount = Account.create(
            id: 'acc_999999',
            initialBalance: 0.0,
            createdAt: DateTime.now(),
          );
          final user2 = User.create(
            userName: defaultUserName, // نفس الـ userName
            firstName: 'Ibrahim', // اسم أول مختلف
            account: differentAccount, // حساب مختلف تماماً
            createdAt: DateTime.now(), // تاريخ مختلف
          );

          expect(
            user1,
            equals(user2),
            reason: 'DDD Entities with the same ID must be equal',
          );
          expect(user1.hashCode, equals(user2.hashCode));
        },
      );

      test(
        'Identity Inequality: Users with different userNames must not be equal',
        () {
          final user1 = User.create(
            userName: UserName.create(value: 'user_7786'),
            firstName: 'Mohamed',
            account: defaultAccount,
            createdAt: defaultCreatedAt,
          );

          final user2 = User.create(
            userName: UserName.create(value: 'user_12224'),
            firstName: 'Mohamed',
            account: defaultAccount,
            createdAt: defaultCreatedAt,
          );

          expect(user1, isNot(equals(user2)));
        },
      );
    });
  });
}
