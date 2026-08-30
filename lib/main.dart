import 'package:finora/core/constants.dart';
import 'package:finora/core/database/isar_database.dart';
import 'package:finora/presentation/dependencies/initial_binding.dart';
import 'package:finora/presentation/screens/add_account/view/add_account_view.dart';
import 'package:finora/presentation/dependencies/add_transaction_dependence.dart';
import 'package:finora/presentation/dependencies/bottom_app_bar_controller_dependence.dart';
import 'package:finora/presentation/dependencies/edit_user_info_dependence.dart';
import 'package:finora/presentation/dependencies/add_account_dependence.dart';
import 'package:finora/presentation/screens/edit_profile/view/edit_user_profile_view.dart';
import 'package:finora/presentation/screens/add_transaction/view/add_transaction_view.dart';
import 'package:finora/presentation/screens/home/view/home_view.dart';
import 'package:finora/presentation/dependencies/signup_model_dependence.dart';
import 'package:finora/presentation/screens/sign_up/view/sign_up.dart';
import 'package:finora/presentation/controller/auth_user_controller.dart';
import 'package:finora/presentation/screens/welcome/view/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:finora/presentation/screens/splash_view/view/splash_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await IsarDatabase.init();

  Get.put(AuthUserController(), permanent: true);

  runApp(const FionarApp());
}

class FionarApp extends StatelessWidget {
  const FionarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      initialRoute: '/splach/',
      getPages: [
        GetPage(
          name: '/splach',
          page: () => const SplashView(),
          transition: Transition.fade,
          transitionDuration: Duration(seconds: kTranstionDuration),
          binding: InitialBinding(),
        ),

        GetPage(
          name: '/welcome',
          page: () => const Welcome(),
          transition: Transition.fade,
          transitionDuration: Duration(seconds: kTranstionDuration),
        ),
        GetPage(
          name: '/signup',
          page: () => const SignUp(),
          transition: Transition.fade,
          transitionDuration: Duration(seconds: kTranstionDuration),
          binding: SignUpBinding(),
        ),
        GetPage(
          name: '/home',
          page: () => HomeView(),
          transition: Transition.fade,
          transitionDuration: Duration(seconds: kTranstionDuration),
          binding: BottomAppBarControllerDependence(),
        ),
        GetPage(
          name: '/edituserinfo',
          page: () => EditUserProfile(),
          transition: Transition.fade,
          transitionDuration: Duration(seconds: kTranstionDuration),
          binding: EditUserInfoDependence(),
        ),
        GetPage(
          name: '/addaccount',
          page: () => AddAccountView(),
          transition: Transition.fade,
          transitionDuration: Duration(seconds: kTranstionDuration),
          binding: AddAccountDependence(),
        ),
        GetPage(
          name: '/addincome',
          page: () => AddTransactionView(type: TransactionType.income),
          transition: Transition.fade,
          transitionDuration: Duration(seconds: kTranstionDuration),
          binding: AddTransactionBinding(),
        ),
        GetPage(
          name: '/addexpense',
          page: () => AddTransactionView(type: TransactionType.expense),
          transition: Transition.fade,
          transitionDuration: Duration(seconds: kTranstionDuration),
          binding: AddTransactionBinding(),
        ),
      ],
    );
  }
}
