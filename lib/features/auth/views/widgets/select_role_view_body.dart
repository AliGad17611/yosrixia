import 'package:flutter/material.dart';
import 'package:yosrixia/features/auth/views/widgets/yosrixia.dart';

class SelectRoleViewBody extends StatelessWidget {
  const SelectRoleViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [
        Yosrixia(),
        SizedBox(height: 30),
      ],
    ));
  }
}
