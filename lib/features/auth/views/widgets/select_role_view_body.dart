import 'package:flutter/material.dart';
import 'package:yosrixia/core/responsive/widget_height.dart';
import 'package:yosrixia/features/auth/views/widgets/child_role.dart';
import 'package:yosrixia/features/auth/views/widgets/doctor_role.dart';
import 'package:yosrixia/features/auth/views/widgets/yosrixia.dart';

class SelectRoleViewBody extends StatelessWidget {
  const SelectRoleViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Yosrixia(),
        SizedBox(height: widgetHeight(context: context, height: 30)),
        const ChildRole(),
        SizedBox(height: widgetHeight(context: context, height: 25)),
        const DoctorRole(),
      ],
    ));
  }
}
