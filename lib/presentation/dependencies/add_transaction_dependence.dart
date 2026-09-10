import 'package:finora/data/repositories/isar_account_repository.dart';
import 'package:finora/domain/repositories/transaction_repository.dart';
import 'package:finora/domain/usecases/transaction/create_transaction_usecase.dart';
import 'package:finora/presentation/screens/add_transaction/view_model/add_transaction_controller.dart';
import 'package:get/get.dart';
import 'package:isar_community/isar.dart';

class AddTransactionBinding extends Bindings {
  @override
  void dependencies() {
    final isarInstance = Get.find<Isar>();
    Get.lazyPut<AddTransactionController>(
      () => AddTransactionController(
        createTransactionUseCase: CreateTransactionUseCase(
          transactionRepository: FakeTransactionRepository(),
          accountRepository: IsarAccountRepository(isarInstance),
        ),
      ),
    );
  }
}
