import 'package:flutter/material.dart';
import 'package:yosrixia/features/doctor/views/widgets/doctor_home_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class DoctorHome extends StatelessWidget {
  const DoctorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: DoctorHomeViewBody());
  }
}
