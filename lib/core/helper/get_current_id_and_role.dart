import 'dart:developer';

import 'package:yosrixia/core/helper/get_current_user_id.dart';
import 'package:yosrixia/core/helper/get_user_role.dart';

Future<Map<String, String?>> getCurrentUserIdAndRole() async {
  String? userId = getCurrentUserId();
  if (userId != null) {
    String? role = await getUserRole(userId);
    return {'userId': userId, 'role': role};
  } else {
    log("No user is currently signed in.");
    return {'userId': null, 'role': null};
  }
}
