import 'package:flutter/material.dart';
import 'package:yosrixia/features/settings/views/widgets/settings_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(
      child: SettingsViewBody(),
    );
  }
}