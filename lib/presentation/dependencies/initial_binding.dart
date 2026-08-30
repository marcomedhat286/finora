import 'package:finora/core/database/isar_database.dart';
import 'package:get/get.dart';
import 'package:isar_community/isar.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Isar>(IsarDatabase.instance, permanent: true);
  }
}
