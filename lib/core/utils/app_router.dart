import 'package:go_router/go_router.dart';
import 'package:yosrixia/features/auth/views/login_view.dart';
import 'package:yosrixia/features/auth/views/widgets/doctor_extra_information.dart';
import 'package:yosrixia/features/auth/views/widgets/email_confirmation.dart';
import 'package:yosrixia/features/auth/views/widgets/register_view.dart';
import 'package:yosrixia/features/auth/views/select_role_view.dart';
import 'package:yosrixia/features/auth/views/widgets/user_information_view.dart';
import 'package:yosrixia/features/child/doctors/views/doctor_details_view.dart';
import 'package:yosrixia/features/child/doctors/views/show_all_doctors_view.dart';
import 'package:yosrixia/features/child/dross/gomal/views/gomal_home_view.dart';
import 'package:yosrixia/features/child/dross/gomal/views/gomal_level_view.dart';
import 'package:yosrixia/features/child/dross/stories/views/stories_home_view.dart';
import 'package:yosrixia/features/child/dross/stories/views/story_view.dart';
import 'package:yosrixia/features/child/dross/words/views/aleph1.dart';
import 'package:yosrixia/features/child/dross/words/views/characters_view.dart';
import 'package:yosrixia/features/child/dross/words/views/dross_home_view.dart';
import 'package:yosrixia/features/child/dross/words/views/sub_character_view.dart';
import 'package:yosrixia/features/child/games/handwriting/views/handwriting_view.dart';
import 'package:yosrixia/features/child/games/views/game_home_view.dart';
import 'package:yosrixia/features/child/games/views/image_name_view.dart';
import 'package:yosrixia/features/child/games/views/word_completion_view.dart';
import 'package:yosrixia/features/child/games/views/word_home_view.dart';
import 'package:yosrixia/features/child/profile/views/child_profile_view.dart';
import 'package:yosrixia/features/child/tips/views/tips_view.dart';
import 'package:yosrixia/features/child/view/child_home_view.dart';
import 'package:yosrixia/features/child/view/child_onboarding_view.dart';
import 'package:yosrixia/features/doctor/views/doctor_home.dart';
import 'package:yosrixia/features/doctor/views/child_details_view.dart';
import 'package:yosrixia/features/onboarding/views/splash_view.dart';
import 'package:yosrixia/features/onboarding/views/welcome_view.dart';
import 'package:yosrixia/features/settings/views/help_center_view.dart';
import 'package:yosrixia/features/settings/views/settings_view.dart';

abstract class AppRouter {
  // welcome routes
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String parentRegister = '/parentRegister';
  static const String selectRole = '/selectRole';
  static const String parentEmailConfirmation = '/parentEmailConfirmation';
  static const String userInformation = '/userInformation';
  static const String doctorExtraInformation = '/doctorExtraInformation';

  // child routes
  static const String childOnboarding = '/childOnboarding';
  static const String childHome = '/childHome';
  static const String droosHome = '/droosHome';
  static const String gamesHome = '/gamesHome';
  static const String showAllDoctorsView = '/showAllDoctorsView';
  static const String tips = '/tips';
  static const String settings = '/settings';
  static const String helpCenter = '/helpCenter';
  // droos routes
  static const String characters = '/characters';
  static const String gomalHome = '/gomalHome';
  static const String storiesHome = '/storiesHome';
  static const String subCharacters = '/subCharacters';
  static const String aleph1 = '/aleph1';
  static const String level = '/level';
  static const String story = '/story';
  // games routes
  static const String wordsQuiz = '/wordsQuiz';
  static const String imageName = '/imageName';
  static const String wordCompletionQuiz = '/wordCompletionQuiz';
  static const String handwriting = '/handwriting';
  // show all doctors routes
  static const String childProfile = '/childProfile';
  static const String doctorDetails = '/doctorDetails';
// doctor routes
  static const String doctorHome = '/doctorHome';
  static const String childDetails = '/childDetails';

  static final router = GoRouter(routes: [
    // welcome routes
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
    // child routes
    GoRoute(
      path: childOnboarding,
      builder: (context, state) => const ChildOnboardingView(),
    ),
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
      path: showAllDoctorsView,
      builder: (context, state) => const ShowAllDoctorsView(),
    ),
    GoRoute(
      path: tips,
      builder: (context, state) => const TipsView(),
    ),
    GoRoute(
      path: settings,
      builder: (context, state) => const SettingsView(),
    ),
    GoRoute(
      path: helpCenter,
      builder: (context, state) => const HelpCenterView(),
    ),
    // droos routes
    GoRoute(
      path: characters,
      builder: (context, state) => const CharactersView(),
    ),
    GoRoute(
      path: gomalHome,
      builder: (context, state) => const GomalHomeView(),
    ),
    GoRoute(
      path: storiesHome,
      builder: (context, state) => const StoriesHomeView(),
    ),
    GoRoute(
      path: subCharacters,
      builder: (context, state) => const SubCharacterView(),
    ),
    GoRoute(
      path: aleph1,
      builder: (context, state) => const Aleph1(),
    ),
    GoRoute(
      path: level,
      builder: (context, state) => const GomalLevelView(),
    ),
    GoRoute(
      path: story,
      builder: (context, state) => const StoryView(),
    ),
    // games routes
    GoRoute(
      path: wordsQuiz,
      builder: (context, state) => const WordHomeView(),
    ),
    GoRoute(
      path: imageName,
      builder: (context, state) => const ImageNameView(),
    ),
    GoRoute(
      path: wordCompletionQuiz,
      builder: (context, state) => const WordCompletionView(),
    ),
    GoRoute(
      path: handwriting,
      builder: (context, state) => const HandwritingView(),
    ),
    // show all doctors routes
    GoRoute(
      path: doctorDetails,
      builder: (context, state) => const DoctorDetailsView(),
    ),
    GoRoute(
      path: doctorHome,
      builder: (context, state) => const DoctorHome(),
    ),
    GoRoute(
      path: childProfile,
      builder: (context, state) => const ChildProfileView(),
    ),
    GoRoute(
      path: childDetails,
      builder: (context, state) => const ChildDetailsView(),
    ),
  ]);
}
