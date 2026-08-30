import 'package:finora/data/repositories/isar_user_repository.dart';
import 'package:finora/domain/usecases/user/update_user_usecase.dart';
import 'package:finora/presentation/screens/edit_profile/view_model/update_user_profile_view_model.dart';
import 'package:get/instance_manager.dart';
import 'package:isar_community/isar.dart';

class EditUserInfoDependence extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateUserInfoViewModel>(
      () => UpdateUserInfoViewModel(
        updateUserUseCase: UpdateUserUseCase(
          userRepository: IsarUserRepository(Get.find<Isar>()),
        ),
      ),
    );
  }
}
