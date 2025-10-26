import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yosrixia/core/database/firebase_services.dart';
import 'package:yosrixia/core/logger/app_logger.dart';

class StorageService {
  final SupabaseClient _supabase;
  StorageService({required SupabaseClient supabase}) : _supabase = supabase;

  Future<String> uploadProfileImage(File file) async {
    AppLogger.logInfo('uploadProfileImage');
    String userId = FirebaseServices.instance.userId;
    AppLogger.logInfo('userId: $userId');
    String fileExtension = file.path.split('.').last; // Get the file extension
    AppLogger.logInfo('fileExtension: $fileExtension');
    String path =
        "profile_images/$userId.$fileExtension"; // Keep original extension
    AppLogger.logInfo('path: $path');
    await _supabase.storage.from('user-profiles').upload(
          path,
          file,
          fileOptions: const FileOptions(upsert: true), // Allows overwriting
        );
    AppLogger.logInfo('upload successful'); 
    String imageUrl = _supabase.storage.from('user-profiles').getPublicUrl(path);
    AppLogger.logInfo("imageUrl: $imageUrl");
    return imageUrl;
  }
}
