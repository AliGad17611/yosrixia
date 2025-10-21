import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
}