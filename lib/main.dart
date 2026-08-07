import 'package:finora/core/constants.dart';
import 'package:finora/presentation/home/view/home.dart';
import 'package:finora/presentation/sign_up/view/sign_up.dart';
import 'package:finora/presentation/sign_up/view_model/auth_controller.dart';
import 'package:finora/presentation/welcome/view/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:finora/presentation/splash_view/view/splash_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController(), permanent: true);

  runApp(const FionarApp());
}

class FionarApp extends StatelessWidget {
  const FionarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      initialRoute: '/splach',
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
        ),
        GetPage(
          name: '/home',
          page: () => const Home(),
          transition: Transition.fade,
          transitionDuration: Duration(seconds: kTranstionDuration),
          // 💡 ممكن تدمج الـ Binding هنا كمان لو تحب
        ),
      ],
    );

    // GetMaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData.light(),
    //   home: const SplashView(),
    // );
  }
}
