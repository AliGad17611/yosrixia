import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yosrixia/core/utils/assets_data.dart';

class ChatUserService {
  static const String _defaultUserName = 'أنت';
  static const String _defaultAIName = 'مساعد يسر';
  static const String _defaultAIImage = AssetsData.logo;

  /// Get current user's display information
  static Future<Map<String, String>> getCurrentUserInfo() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return {
          'name': _defaultUserName,
          'imageUrl': '',
        };
      }

      // Try to get user info from Firestore
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>;
        return {
          'name': data['name'] ?? user.displayName ?? _defaultUserName,
          'imageUrl': data['imageUrl'] ?? user.photoURL ?? '',
        };
      }

      // Fallback to Firebase Auth user info
      return {
        'name': user.displayName ?? _defaultUserName,
        'imageUrl': user.photoURL ?? '',
      };
    } catch (e) {
      // Return default values if there's any error
      return {
        'name': _defaultUserName,
        'imageUrl': '',
      };
    }
  }

  /// Get AI assistant information
  static Map<String, String> getAIInfo() {
    return {
      'name': _defaultAIName,
      'imageUrl': _defaultAIImage,
    };
  }
}
