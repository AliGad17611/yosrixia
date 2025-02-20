import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/helper/get_current_id_and_role.dart';
import 'package:yosrixia/core/helper/get_current_user_id.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/constants.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late BuildContext _context;

  @override
  void initState() {
    // Calling the function to check user role or ID
    _context = context;
    checkUserRole();
    super.initState();
  }

  void checkUserRole() async {
    final userId = getCurrentUserId();
    if (userId == null) {
      // Use addPostFrameCallback to delay navigation until after the build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          GoRouter.of(_context).go(AppRouter.welcome);
        }
      });
    } else {
      final role = await getCurrentUserIdAndRole();
      if (role['role'] == 'child') {
        if (!mounted) return;
        GoRouter.of(_context).go(AppRouter.childHome);
      } else if (role['role'] == 'doctor') {
        if (!mounted) return;
        GoRouter.of(_context).go(AppRouter.doctorHome);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
      ),
    );
  }
}
