import 'package:flutter/material.dart';
import 'package:yosrixia/features/auth/views/widgets/select_role_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class SelectRoleView extends StatelessWidget {
  const SelectRoleView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: SelectRoleViewBody());
  }
}