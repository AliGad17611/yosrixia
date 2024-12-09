import 'package:flutter/material.dart';
import 'package:yosrixia/features/auth/views/widgets/parent%20registeration/parent_register_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class ParentRegisterView extends StatelessWidget {
  const ParentRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: ParentRegisterViewBody());
  }
}