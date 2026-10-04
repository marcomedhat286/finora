import 'package:finora/data/repositories/isar_account_repository.dart';
import 'package:finora/data/repositories/isar_transaction_repository.dart';
import 'package:finora/domain/usecases/account/delete_account_usecase.dart';
import 'package:finora/domain/usecases/account/update_account_usecase.dart';
import 'package:finora/domain/usecases/transaction/get_transaction_usecase.dart';
import 'package:finora/presentation/screens/view_account/view_model/get_list_view_account_transactoin_controller.dart';
import 'package:finora/presentation/screens/view_account/view_model/update_delete_account_controller.dart';
import 'package:get/get.dart';
import 'package:isar_community/isar.dart';

class ViewAccountDependence extends Bindings {
  @override
  void dependencies() {
    final isar = Get.find<Isar>();
    final isarAccountRepository = IsarAccountRepository(isar);
    final isarTransactionRepository = IsarTransactionRepository(isar: isar);
    Get.lazyPut<UpdateDeleteAccountController>(
      () => UpdateDeleteAccountController(
        updateAccountUsecase: UpdateAccountUsecase(
          accountRepository: isarAccountRepository,
        ),
        deleteAccountUsecase: DeleteAccountUsecase(
          accountRepository: isarAccountRepository,
          transactionRepository: isarTransactionRepository,
        ),
      ),
    );
    Get.lazyPut<GetListViewAccountTransactoinController>(
      () => GetListViewAccountTransactoinController(
        GetTransactionUsecase(transactionRepository: isarTransactionRepository),
      ),
    );
  }
}
