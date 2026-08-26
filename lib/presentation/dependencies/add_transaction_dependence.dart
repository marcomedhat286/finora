import 'package:finora/domain/repositories/account_repository.dart';
import 'package:finora/domain/repositories/transaction_repository.dart';
import 'package:finora/domain/usecases/transaction/create_transaction_usecase.dart';
import 'package:finora/presentation/screens/add_transaction/view_model/add_transaction_controller.dart';
import 'package:get/get.dart';

class AddTransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTransactionController>(
      () => AddTransactionController(
        createTransactionUseCase: CreateTransactionUseCase(
          transactionRepository: FakeTransactionRepository(),
          accountRepository: FakeAccountRepository(),
        ),
      ),
    );
  }
}
