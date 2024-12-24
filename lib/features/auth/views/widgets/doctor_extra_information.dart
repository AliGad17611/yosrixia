import 'package:flutter/material.dart';
import 'package:yosrixia/features/auth/views/widgets/doctor_extra_information_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class DoctorExtraInformation extends StatelessWidget {
  const DoctorExtraInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: DoctorExtraInformationBody());

  }
}