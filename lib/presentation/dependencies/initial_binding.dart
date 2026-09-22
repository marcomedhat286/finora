import 'package:finora/core/database/isar_database.dart';
import 'package:finora/presentation/controller/auth_accounts_controller.dart';
import 'package:finora/presentation/controller/auth_transactions_controller.dart';
import 'package:finora/presentation/controller/auth_user_controller.dart';
import 'package:get/get.dart';
import 'package:isar_community/isar.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthUserController(), permanent: true);
    Get.put(AuthAccountsController(), permanent: true);
    Get.put(AuthTransactionsController(), permanent: true);
    Get.put<Isar>(IsarDatabase.instance, permanent: true);
  }
}
