import 'package:finora/core/constants.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:finora/presentation/splash_view/view/splash_view.dart';

void main() {
  runApp(const FionarApp());
}

class FionarApp extends StatelessWidget {
  const FionarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const SplashView(),
    );
  }
}
