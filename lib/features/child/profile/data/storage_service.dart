import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<String?> uploadProfileImage(File file) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String path = "profile_images/$userId.jpg";

    try {
      await supabase.storage.from('user_uploads').upload(path, file);
      return supabase.storage.from('user_uploads').getPublicUrl(path);
    } catch (e) {
      log("Upload Error: $e");
      return null;
    }
  }
}
