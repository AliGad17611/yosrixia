import 'package:flutter/material.dart';
import 'package:yosrixia/features/auth/views/widgets/user_information_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class UserInformationView extends StatelessWidget {
  const UserInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: UserInformationViewBody(),);
  }
}