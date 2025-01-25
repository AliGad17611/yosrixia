import 'package:go_router/go_router.dart';
import 'package:yosrixia/features/auth/views/login_view.dart';
import 'package:yosrixia/features/auth/views/widgets/doctor_extra_information.dart';
import 'package:yosrixia/features/auth/views/widgets/email_confirmation.dart';
import 'package:yosrixia/features/auth/views/widgets/register_view.dart';
import 'package:yosrixia/features/auth/views/select_role_view.dart';
import 'package:yosrixia/features/auth/views/widgets/user_information_view.dart';
import 'package:yosrixia/features/child/dross/views/characters_view.dart';
import 'package:yosrixia/features/child/dross/views/dross_home_view.dart';
import 'package:yosrixia/features/child/dross/views/sub_character_view.dart';
import 'package:yosrixia/features/child/games/views/game_home_view.dart';
import 'package:yosrixia/features/child/view/child_home_view.dart';
import 'package:yosrixia/features/doctor/views/doctor_home.dart';
import 'package:yosrixia/features/child/dross/views/aleph1.dart';
import 'package:yosrixia/features/onboarding/views/splash_view.dart';
import 'package:yosrixia/features/onboarding/views/welcome_view.dart';

abstract class AppRouter {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String parentRegister = '/parentRegister';
  static const String childHome = '/childHome';
  static const String droosHome = '/droosHome';
  static const String gamesHome = '/gamesHome';
  static const String characters = '/characters';
  static const String subCharacters = '/subCharacters';
  static const String home = '/home';
  static const String selectRole = '/selectRole';
  static const String parentEmailConfirmation = '/parentEmailConfirmation';
  static const String userInformation = '/userInformation';
  static const String doctorExtraInformation = '/doctorExtraInformation';
  static const String aleph1 = '/aleph1';
  static const String doctorHome = '/doctorHome';
  static final router = GoRouter(routes: [
    GoRoute(
      path: splash,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: welcome,
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
      builder: (context, state) {
        final extraValue = state.extra as String?; // Retrieve the 'extra' value
        return RegisterView(
          extra: extraValue,
        );
      },
    ),
    GoRoute(
      path: parentEmailConfirmation,
      builder: (context, state) => const EmailConfirmation(),
    ),
    GoRoute(
      path: userInformation,
      builder: (context, state) => const UserInformationView(),
    ),
    GoRoute(
        path: doctorExtraInformation,
        builder: (context, state) => const DoctorExtraInformation()),
    GoRoute(
      path: childHome,
      builder: (context, state) => const ChildHomeView(),
    ),
    GoRoute(
      path: droosHome,
      builder: (context, state) => const DrossHomeView(),
    ),
    GoRoute(
      path: gamesHome,
      builder: (context, state) => const GameHomeView(),
    ),
    GoRoute(
      path: characters,
      builder: (context, state) => const CharactersView(),
    ),
    GoRoute(
      path: subCharacters,
      builder: (context, state) => const SubCharacterView(),
    ),
    GoRoute(
      path: aleph1,
      builder: (context, state) => const Aleph1(),
    ),
    GoRoute(path: doctorHome, builder: (context, state) => const DoctorHome()),
  ]);
}
