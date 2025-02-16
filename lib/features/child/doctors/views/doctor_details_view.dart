import 'package:flutter/material.dart';
import 'package:yosrixia/features/child/doctors/views/widgets/doctor_details_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class DoctorDetailsView extends StatelessWidget {
  const DoctorDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: DoctorDetailsViewBody());
  }
}