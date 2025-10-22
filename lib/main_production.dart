import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yosrixia/core/di/dependency_injection.dart';
import 'package:yosrixia/core/services/app_usage_tracker.dart';
import 'package:yosrixia/features/subscripton_and_payments/manger/services/payment_services.dart';
import 'package:yosrixia/firebase_options.dart';
import 'package:yosrixia/supabase_config.dart';
import 'package:yosrixia/yosrixia_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //* initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //* initialize supabase
  await SupabaseConfig.init();
  //* initialize paymob
  await PaymentServices.initPaymob();
  //* initialize hive
  await Hive.initFlutter();
  //* initialize Dependencies
  await setupDependencyInjection();

  // Initialize app usage tracker
  await AppUsageTracker().init();

  runApp(const YosrixiaApp());
}
