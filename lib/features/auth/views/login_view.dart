import 'package:flutter/material.dart';
import 'package:yosrixia/features/auth/views/widgets/login_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: LoginViewBody());
  }
}