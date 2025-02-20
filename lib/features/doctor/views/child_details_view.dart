import 'package:flutter/material.dart';
import 'package:yosrixia/features/doctor/views/widgets/child_details_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class ChildDetailsView extends StatelessWidget {
  const ChildDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: ChildDetailsViewBody(),);
  }
}
