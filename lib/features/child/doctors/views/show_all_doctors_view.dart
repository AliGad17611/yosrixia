import 'package:flutter/widgets.dart';
import 'package:yosrixia/features/child/doctors/views/widgets/show_all_doctors_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class ShowAllDoctorsView extends StatelessWidget {
  const ShowAllDoctorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: ShowAllDoctorsViewBody());
  }
}