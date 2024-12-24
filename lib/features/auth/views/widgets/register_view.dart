import 'package:flutter/material.dart';
import 'package:yosrixia/features/auth/views/widgets/register_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key,this.extra});

  final String? extra;
  @override
  Widget build(BuildContext context) {
    return  BackGround(child: RegisterViewBody(extra: extra,));
  }
}