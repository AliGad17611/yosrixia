import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/database/firebase_services.dart';
import 'package:yosrixia/core/helper/get_current_id_and_role.dart';
import 'package:yosrixia/core/helper/global_variable.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/features/child/profile/data/firestore_service.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkUserRole());
  }

  Future<void> checkUserRole() async {
    final userId = FirebaseServices.instance.userId;
    if (userId.isEmpty) {
      if (!mounted) return;
      GoRouter.of(context).go(AppRouter.welcome);
      return;
    }

    final role = await getCurrentUserIdAndRole();
    final firestoreService = FirestoreService();
    final isUserDataExist = await firestoreService.doesNameExist(userId);

    if (!mounted) return;

    userRole = role['role'] ?? '';

    if (!isUserDataExist) {
      GoRouter.of(context).go(AppRouter.userInformation);
      return;
    }

    if (role['role'] == 'child') {
      GoRouter.of(context).go(AppRouter.childHome);
    } else if (role['role'] == 'doctor') {
      GoRouter.of(context).go(AppRouter.doctorHome);
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
