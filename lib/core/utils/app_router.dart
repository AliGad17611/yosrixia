import 'package:go_router/go_router.dart';
import 'package:yosrixia/features/auth/views/login_view.dart';
import 'package:yosrixia/features/auth/views/widgets/parent%20registeration/parent_email_confirmation.dart';
import 'package:yosrixia/features/auth/views/widgets/parent%20registeration/parent_register_view.dart';
import 'package:yosrixia/features/auth/views/select_role_view.dart';
import 'package:yosrixia/features/onboarding/views/welcome_view.dart';

abstract class AppRouter {
  static const String onboarding = '/';
  static const String login = '/login';
  static const String parentRegister = '/parentRegister';
  static const String home = '/home';
  static const String selectRole = '/selectRole';
  static const String parentEmailConfirmation = '/parentEmailConfirmation';
  static final router = GoRouter(routes: [
    GoRoute(
      path: onboarding,
      builder: (context, state) => const WelcomeView(),
    ),
    GoRoute(
      path: login,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: selectRole,
      builder: (context, state) => const SelectRoleView(),
    ),
    GoRoute(
      path: parentRegister,
      builder: (context, state) => const ParentRegisterView(),
    ),
    GoRoute(path: parentEmailConfirmation,
    builder: (context, state) => const ParentEmailConfirmation(),
    ),
    
  ]);
}
