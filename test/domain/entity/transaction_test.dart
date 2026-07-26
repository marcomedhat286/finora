import 'package:finora/domain/entities/transaction.dart';
import 'package:finora/domain/exception/invalid_make_transaction.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finora/domain/entities/user.dart';
import 'package:finora/domain/entities/account.dart';
import 'package:finora/domain/entities/expense.dart';
import 'package:finora/domain/entities/income.dart';
import 'package:finora/domain/value_object/user_name.dart';
import 'package:finora/domain/exception/invalid_format_exception.dart';

void main() {
  group('🛡️ Finora Comprehensive Integration Suite (User, Account & Transactions)', () {
    late UserName validUserName;
    late DateTime fixedCreatedAt;

    setUp(() {
      validUserName = UserName.create(value: "ahmed_99");
      // تاريخ ثابت لضمان عدم حدوث تفاوت أجزاء من الثانية أثناء الاختبارات
      fixedCreatedAt = DateTime.now();
    });

    // =========================================================================
    // 1. اختبارات الـ Domain Validation والـ Business Rules للـ User
    // =========================================================================
    group('👤 User Validation & Personal Names', () {
      test(
        'Should successfully create a User with only required fields and format fullName correctly',
        () {
          final account = Account.create(
            id: "acc_001",
            initialBalance: 1000.0,
            createdAt: fixedCreatedAt,
          );

          final user = User.create(
            userName: validUserName,
            firstName: "Ahmed",
            account: account,
            createdAt: fixedCreatedAt,
          );

          expect(user.userName.value, "ahmed_99");
          expect(user.firstName.value, "Ahmed");
          expect(user.middleName, isNull);
          expect(user.lastName, isNull);
          expect(user.fullName, "Ahmed");
          expect(user.account.id, "acc_001");
        },
      );

      test(
        'Should format fullName with optional middle and last names when provided',
        () {
          final account = Account.create(
            id: "acc_001",
            createdAt: fixedCreatedAt,
            initialBalance: 1000.0,
          );

          final user = User.create(
            userName: validUserName,
            firstName: "Ahmed",
            middleName: "Ali",
            lastName: "Hassan",
            account: account,
            createdAt: fixedCreatedAt,
          );

          expect(user.fullName, "Ahmed Ali Hassan");
        },
      );

      test(
        'Should throw Exception when firstName violates length or content rules',
        () {
          final account = Account.create(
            id: "acc_001",
            createdAt: fixedCreatedAt,
            initialBalance: 1000.0,
          );

          expect(
            () => User.create(
              userName: validUserName,
              firstName: "A", // قصير جداً (يفترض أن PersonName يرفضه)
              account: account,
              createdAt: fixedCreatedAt,
            ),
            throwsA(isA<InvalidFormatException>()),
          );
        },
      );
    });

    group('Finora Epic Domain Integration Tests (User -> Account -> Transactions)', () {
      test(
        'Should survive a month of chaotic transactions, rollbacks, validation failures, and audits',
        () {
          // ────────────────────────────────────────────────────────
          // 1. إنشاء المستخدم بحسابه المالي (الرصيد الابتدائي: 2000.0)
          // ────────────────────────────────────────────────────────
          final account = Account.create(
            id: "acc_001",
            initialBalance: 2000.0,
            createdAt: fixedCreatedAt,
          );
          User user = User.create(
            userName: validUserName,
            firstName: "ahmed",
            middleName: "ali",
            account: account,
            createdAt: fixedCreatedAt,
          );

          // تأكيدات البداية
          expect(user.fullName, "ahmed ali");
          expect(user.account.id, "acc_001");
          expect(user.account.currentBalance.value, 2000.0);
          print(user);
          print('-' * 100);

          // ────────────────────────────────────────────────────────
          // 2. تطبيق الحركات المالية على حساب المستخدم
          // ────────────────────────────────────────────────────────

          // أ. إضافة مصروف بقالة بـ 450.0
          final groceryTx = Expense.create(
            id: "tx_001",
            title: "شراء بقالة للشهر",
            accountId: user.account.id,
            amount: 450.0,
            createdAt: fixedCreatedAt,
          );
          print(groceryTx.displayData);
          print('-' * 100);
          user = user.copyWith(
            account: user.account.applyNewTransaction(groceryTx),
          );

          // الرصيد المتوقع: 2000 - 450 = 1550.0
          expect(user.account.currentBalance.value, 1550.0);
          print(user);
          print('-' * 100);

          // ب. إضافة إيراد فريلانس بـ 1200.0
          final freelanceTx = Income.create(
            id: "tx_002",
            title: "مشروع فريلانس سريع",
            accountId: user.account.id,
            amount: 1200.0,
            createdAt: DateTime.now().subtract(const Duration(days: 4)),
          );
          print(freelanceTx.displayData);
          print('-' * 100);

          user = user.copyWith(
            account: user.account.applyNewTransaction(freelanceTx),
          );

          // // الرصيد المتوقع: 1550 + 1200 = 2750.0
          expect(user.account.currentBalance.value, 2750.0);
          print(user);
          print('-' * 100);

          // // ج. إضافة مصروف كهرباء بـ 150.0
          final electricityTx = Expense.create(
            id: "tx_003",
            title: "فاتورة الكهرباء",
            accountId: user.account.id,
            amount: 150.0,
            createdAt: DateTime.now().subtract(const Duration(days: 3)),
          );
          print(electricityTx.displayData);
          print('-' * 100);

          user = user.copyWith(
            account: user.account.applyNewTransaction(electricityTx),
          );

          // الرصيد المتوقع: 2750 - 150 = 2600.0
          expect(user.account.currentBalance.value, 2600.0);
          print(user);
          print('-' * 100);

          // // ────────────────────────────────────────────────────────
          // // 3. اختبار اختراق حارس البوابة (سحب في السالب)
          // // ────────────────────────────────────────────────────────
          // // محاولة شراء لابتوب بـ 4000.0 والرصيد المتاح 2600.0 فقط
          final expensiveLaptopTx = Expense.create(
            id: "tx_004",
            title: "لابتوب جديد للعمل",
            accountId: user.account.id,
            amount: 4000.0,
            createdAt: DateTime.now(),
          );
          print(expensiveLaptopTx.displayData);
          print('-' * 100);
          // نتوقع أن يرفض الحساب هذه المعاملة فوراً ويحافظ على سلامة الرصيد دون تغيير
          expect(
            () => user.account.applyNewTransaction(expensiveLaptopTx),
            throwsA(isA<InvalidMakeTransaction>()),
          );
          print(user);
          print('-' * 100);

          // // نتأكد أن الرصيد لم يتأثر نهائياً وظل 2600.0
          expect(user.account.currentBalance.value, 2600.0);

          // // ────────────────────────────────────────────────────────
          // // 4. مسح وتراجع عن حركة مالية (Rollback)
          // // ────────────────────────────────────────────────────────
          // // تم إلغاء ومسح فاتورة الكهرباء (tx_003)، فنعكس أثرها المالي
          user = user.copyWith(
            account: user.account.rollbackDeletedTransaction(electricityTx),
          );

          // // الرصيد المتوقع بعد التراجع والمسح: 2600 + 150 = 2750.0
          expect(user.account.currentBalance.value, 2750.0);
          print(user);
          print('-' * 100);
          // // ────────────────────────────────────────────────────────
          // // 5. التعديل التاريخي وإعادة الجرد التراكمي (Full Domain Audit)
          // // ────────────────────────────────────────────────────────
          // // المستخدم قام بتعديل قيمة الـ Freelance (tx_002) من 1200.0 لتصبح 1500.0
          final updatedFreelanceTx = Income.create(
            id: "tx_002", // نفس الـ ID القديم للتعديل عليه
            title: "مشروع فريلانس سريع",
            accountId: user.account.id,
            amount: 1500.0, // القيمة الجديدة بعد التعديل
            createdAt: DateTime.now().subtract(const Duration(days: 4)),
          );

          // // لستة المعاملات الفعلية المتبقية والمعدلة في قاعدة البيانات حالياً هي:
          // // [ البقالة (450-) ، الفريلانس المعدل (1500+) ]
          // // الكهرباء غير موجودة لأنها حُذفت في الخطوة السابقة.
          final List<Transaction> activeDatabaseLedger = [
            groceryTx,
            updatedFreelanceTx,
          ];

          // // إعادة الجرد الشامل بناءً على السجل الحقيقي للتأكد من عدم ترحيل مليم واحد
          user = user.copyWith(
            account: user.account.recalculateFromLedger(activeDatabaseLedger),
          );

          // // الحسبة الرياضية النهائية الصارمة:
          // // الرصيد الافتتاحي (2000.0) - البقالة (450.0) + الفريلانس المعدل (1500.0) = 3050.0 جنيه!
          expect(user.account.currentBalance.value, 3050.0);
          print(user);
          print('-' * 100);
          // // طباعة النتيجة النهائية للتأكيد البصري على نجاح الدورة كاملة
          print(
            "🚀 Epic Test Passed! User: ${user.fullName} | Final Confirmed Balance: \$${user.account.currentBalance.value}",
          );
        },
      );
    });
    // // =========================================================================
    // // 2. اختبارات تكامل الحساب والعمليات المالية (User - Account - Transactions Flow)
    // // =========================================================================
    group('💰 Financial Integration Flow', () {
      test(
        'Should accurately reflect multiple Incomes and Expenses on the User\'s Account Balance',
        () {
          // 1. إنشاء حساب برصيد ابتدائي 5000.00 جنيه
          var account = Account.create(
            id: "acc_002",
            createdAt: fixedCreatedAt,
            initialBalance: 5000.0,
          );

          var user = User.create(
            userName: validUserName,
            firstName: "Mostafa",
            account: account,
            createdAt: fixedCreatedAt,
          );
          print(user);
          print('-' * 100);
          expect(user.account.initialBalance.value, 5000.0);

          //2. محاكاة إضافة Income (مثال: راتب إضافي 2500)
          final bonusIncome = Income.create(
            id: "tx_1",
            title: "Freelance Project",
            accountId: account.id,
            amount: 2500.0,
            createdAt: fixedCreatedAt,
          );
          print(bonusIncome.displayData);
          print('-' * 100);
          // // نقوم بتحديث الحساب من خلال تفعيل الأثر المالي للإيراد
          account = user.account.applyNewTransaction(bonusIncome);
          user = user.copyWith(account: account);

          // // الرصيد المتوقع: 5000 + 2500 = 7500
          expect(user.account.currentBalance.value, 7500.0);
          print(user);
          print('-' * 100);

          // // 3. محاكاة إضافة Expense (مثال: دفع فاتورة كهرباء 350)
          final electricityExpense = Expense.create(
            id: "tx_12",
            title: "Electricity Bill",
            accountId: account.id,
            amount: 350.0,
            createdAt: fixedCreatedAt,
          );
          print(electricityExpense.displayData);
          print('-' * 100);

          account = user.account.applyNewTransaction(electricityExpense);
          user = user.copyWith(account: account);

          // // الرصيد المتوقع بعد الخصم: 7500 - 350 = 7150
          expect(user.account.currentBalance.value, 7150.0);
          print(user);
          print('-' * 100);
        },
      );
    });

    // // =========================================================================
    // // 3. اختبارات الـ Immutability والنسخ المتطور (CopyWith & Sentinel)
    // // =========================================================================
    group('🔄 Immutability & copyWith (Sentinel Pattern)', () {
      test(
        'copyWith should update fields while leaving omitted fields untouched',
        () {
          final account = Account.create(
            id: "acc_001",
            createdAt: fixedCreatedAt,
            initialBalance: 100.0,
          );
          final user = User.create(
            userName: validUserName,
            firstName: "Kareem",
            middleName: "Samir",
            lastName: "Farouk",
            account: account,
            createdAt: fixedCreatedAt,
          );

          // تعديل الاسم الأول فقط
          final updatedUser = user.copyWith(firstName: "Karim");

          expect(updatedUser.firstName.value, "Karim");
          expect(updatedUser.middleName?.value, "Samir"); // لم يتغير
          expect(updatedUser.lastName?.value, "Farouk"); // لم يتغير
          print(updatedUser);
        },
      );

      test(
        'copyWith should explicitly set optional fields to null using sentinel',
        () {
          final account = Account.create(
            id: "acc_001",
            createdAt: fixedCreatedAt,
            initialBalance: 100.0,
          );
          final user = User.create(
            userName: validUserName,
            firstName: "Kareem",
            middleName: "Samir",
            lastName: "Farouk",
            account: account,
            createdAt: fixedCreatedAt,
          );

          // تصفير الـ middleName والـ lastName تماماً عن طريق تمرير null صريح
          final clearedUser = user.copyWith(middleName: null, lastName: null);

          expect(clearedUser.firstName.value, "Kareem");
          expect(clearedUser.middleName, isNull); // تم تصفيره بنجاح!
          expect(clearedUser.lastName, isNull); // تم تصفيره بنجاح!
          print(clearedUser);
        },
      );
    });

    // // =========================================================================
    // // 4. اختبارات الهوية وعقود التساوي (Entity Equality & HashCode)
    // // =========================================================================
    group('🆔 Domain Entity Identity (Equality)', () {
      test(
        'Two User instances with the same UserName must be equal regardless of other fields',
        () {
          final accountA = Account.create(
            id: "acc_123454",
            createdAt: fixedCreatedAt,
            initialBalance: 100.0,
          );
          final accountB = Account.create(
            id: "acc_84758927",
            createdAt: fixedCreatedAt,
            initialBalance: 9999.0,
          );

          final userA = User.create(
            userName: validUserName, // نفس الـ UserName
            firstName: "Ahmed",
            account: accountA,
            createdAt: fixedCreatedAt,
          );

          final userB = User.create(
            userName: validUserName, // نفس الـ UserName
            firstName: "Sayed", // اسم مختلف
            middleName: "Wagih",
            account: accountB, // حساب مالي مختلف تماماً برصيد مختلف
            createdAt: fixedCreatedAt,
          );

          // قانون الـ Domain Entity: الهوية بالـ ID (الـ UserName هنا)
          expect(userA, equals(userB));
          expect(userA.hashCode, equals(userB.hashCode));
        },
      );
    });

    // // =========================================================================
    // // 5. اختبارات الـ Serialization والـ JSON (Data Integrity)
    // // =========================================================================
    group('💾 Serialization & De-serialization', () {
      test(
        'toMap and fromJson should maintain complete data integrity across nesting',
        () {
          final account = Account.create(
            id: "acc_001",
            createdAt: fixedCreatedAt,
            initialBalance: 1200.50,
          );
          final originalUser = User.create(
            userName: validUserName,
            firstName: "Omar",
            middleName: "Saeed",
            lastName: "Kamal",
            account: account,
            createdAt: fixedCreatedAt,
          );

          // 1. تحويل الكائن بالكامل (ومعه الـ Account الداخلي) إلى Map
          final userMap = originalUser.toMap();

          expect(userMap['userName'], "ahmed_99");
          expect(userMap['firstName'], "Omar");
          expect(userMap['middleName'], "Saeed");
          expect(userMap['lastName'], "Kamal");
          expect(userMap['account']['id'], "acc_001");
          expect(userMap['account']['initialBalance'], 1200.50);
          expect(userMap['account']['currentBalance'], 1200.50);
          expect(
            userMap['account']['createdAt'],
            fixedCreatedAt.toIso8601String(),
          );
          expect(userMap['createdAt'], fixedCreatedAt.toIso8601String());

          // 2. إعادة البناء من الـ Map
          final restoredUser = User.fromJson(json: userMap);

          expect(restoredUser.userName.value, originalUser.userName.value);
          expect(restoredUser.fullName, originalUser.fullName);
          expect(restoredUser.account, originalUser.account);
          expect(restoredUser.createdAt, originalUser.createdAt);
        },
      );
    });
  });
}
