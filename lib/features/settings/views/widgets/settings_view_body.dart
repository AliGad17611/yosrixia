import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/features/settings/views/widgets/settings_button.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            SettingsButton(
                text: 'الصفحة الشخصية',
                onTap: () {
                  GoRouter.of(context).push(AppRouter.childProfile);
                },
                icon: Icons.account_circle_outlined),
            SettingsButton(
                text: 'مركز المساعدة', onTap: () {}, icon: Icons.support_agent),
            SettingsButton(
                text: 'تسجيل الخروج', onTap: () {}, icon: Icons.logout),
          ],
        ),
      ),
    );
  }
}
