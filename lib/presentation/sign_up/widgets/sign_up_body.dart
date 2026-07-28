import 'package:finora/presentation/sign_up/widgets/custome_sign_up_data_container.dart';
import 'package:finora/presentation/sign_up/widgets/many_circles_container.dart';
import 'package:flutter/material.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenheight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        ManyCirclesContainer(
          screenWidth: screenWidth,
          screenheight: screenheight,
        ),
        const CustomeSignUpDataContainer(),
      ],
    );
  }
}
