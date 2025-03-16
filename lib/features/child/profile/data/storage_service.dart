import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<String?> uploadProfileImage(File file) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String fileExtension = file.path.split('.').last; // Get the file extension
    String path =
        "profile_images/$userId.$fileExtension"; // Keep original extension

    try {
      await supabase.storage.from('user_uploads').upload(
            path,
            file,
            fileOptions: const FileOptions(upsert: true), // Allows overwriting
          );

      String imageUrl =
          supabase.storage.from('user_uploads').getPublicUrl(path);
      log("Upload Successful: $imageUrl");
      return imageUrl;
    } catch (e) {
      log("Upload Error: $e");
      return null;
    }
  }
}
