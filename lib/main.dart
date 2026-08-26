import 'package:finora/core/constants.dart';
import 'package:finora/presentation/dependencies/add_transaction_dependence.dart';
import 'package:finora/presentation/dependencies/bottom_app_bar_controller_dependence.dart';
import 'package:finora/presentation/screens/add_transaction/view/add_transaction_view.dart';
import 'package:finora/presentation/screens/home/view/home_view.dart';
import 'package:finora/presentation/dependencies/signup_model_dependence.dart';
import 'package:finora/presentation/screens/sign_up/view/sign_up.dart';
import 'package:finora/presentation/controller/auth_user_controller.dart';
import 'package:finora/presentation/screens/welcome/view/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:finora/presentation/screens/splash_view/view/splash_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
          name: '/addincome',
          page: () => AddTransactionView(type: TransactionType.Income),
          transition: Transition.fade,
          transitionDuration: Duration(seconds: kTranstionDuration),
          binding: AddTransactionBinding(),
        ),
        GetPage(
          name: '/addexpense',
          page: () => AddTransactionView(type: TransactionType.Expense),
          transition: Transition.fade,
          transitionDuration: Duration(seconds: kTranstionDuration),
          binding: AddTransactionBinding(),
        ),
      ],
    );
  }
}
