import 'package:flutter/material.dart';
import 'package:yosrixia/features/parent_profile/views/widgets/parent_profile_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class ParentProfileView extends StatelessWidget {
  const ParentProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: ParentProfileViewBody());
  }
}
