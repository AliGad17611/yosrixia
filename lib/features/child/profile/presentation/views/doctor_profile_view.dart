import 'package:flutter/material.dart';
import 'package:yosrixia/features/child/profile/presentation/views/widgets/doctor_profile_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class DoctorProfileView extends StatelessWidget {
  const DoctorProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: DoctorProfileViewBody());
  }
}
