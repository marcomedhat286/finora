import 'package:finora/data/repositories/isar_transaction_repository.dart';
import 'package:finora/domain/usecases/transaction/get_transaction_usecase.dart';
import 'package:finora/domain/usecases/transaction/search_transactions_usecase.dart';
import 'package:finora/presentation/screens/home/view_model.dart/bottom_app_bar_controller.dart';
import 'package:finora/presentation/screens/home/view_model.dart/view_transaction_view_controller.dart';
import 'package:finora/presentation/screens/transaction_search/view_model/flitter_search_transactions_controller.dart';
import 'package:get/get.dart';
import 'package:isar_community/isar.dart';

class HomeControllersDependence extends Bindings {
  @override
  void dependencies() {
    final respority = IsarTransactionRepository(isar: Get.find<Isar>());
    Get.lazyPut<BottomAppBarController>(() => BottomAppBarController());
    Get.lazyPut<ViewTransactionController>(
      () => ViewTransactionController(
        GetTransactionUsecase(transactionRepository: respority),
      ),
    );
    Get.lazyPut<FlitterSearchTransactionsController>(
      () => FlitterSearchTransactionsController(
        searchTransactionsUsecase: SearchTransactionsUsecase(
          transactionRepository: respority,
        ),
      ),
    );
  }
}
