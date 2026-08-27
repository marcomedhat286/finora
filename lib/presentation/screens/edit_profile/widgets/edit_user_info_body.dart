import 'package:finora/presentation/screens/edit_profile/widgets/display_updated_user_info.dart';
import 'package:finora/presentation/screens/sign_up/widgets/many_circles_container.dart';
import 'package:flutter/material.dart';

class EditUserInfoBody extends StatelessWidget {
  const EditUserInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Stack(
        children: [ManyCirclesContainer(), DisplayUpdatedUserInfo()],
      ),
    );
  }
}
