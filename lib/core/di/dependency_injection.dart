import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yosrixia/features/child/profile/data/services/profile_service.dart';
import 'package:yosrixia/features/child/profile/data/services/storage_service.dart';
import 'package:yosrixia/features/child/profile/data/repo/profile_repo.dart';
import 'package:yosrixia/features/child/profile/presentation/cubits/child_info_cubit/child_info_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {

  //====== Core ======
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  getIt.registerSingleton<SupabaseClient>(Supabase.instance.client);

  //====== Features ======

  // Profile

  // profile service
  getIt.registerLazySingleton<ProfileService>(() => ProfileService(auth: getIt<FirebaseAuth>(), firestore: getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<StorageService>(() => StorageService(supabase: getIt<SupabaseClient>()));
  // profile repo
  getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepo(profileService: getIt<ProfileService>(), storageService: getIt<StorageService>()));

  // profile cubits
  getIt.registerLazySingleton<ChildInfoCubit>(() => ChildInfoCubit(profileRepo: getIt<ProfileRepo>()));
}