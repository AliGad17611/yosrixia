import 'package:flutter/material.dart';
import 'package:yosrixia/features/settings/views/widgets/help_center_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class HelpCenterView extends StatelessWidget {
  const HelpCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: HelpCenterViewBody());  
  }
}
