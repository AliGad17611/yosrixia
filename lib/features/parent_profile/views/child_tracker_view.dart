import 'package:flutter/material.dart';
import 'package:yosrixia/features/parent_profile/views/widgets/child_tracker_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class ChildTrackerView extends StatelessWidget {
  const ChildTrackerView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: ChildTrackerViewBody());
  }
}
