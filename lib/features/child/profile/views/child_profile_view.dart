import 'package:flutter/material.dart';
import 'package:yosrixia/features/child/profile/views/widgets/child_profile_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class ChildProfileView extends StatelessWidget {
  const ChildProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: ChildProfileViewBody());
  }
}