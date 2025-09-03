
import 'package:yosrixia/core/database/firebase_services.dart';
import 'package:yosrixia/core/helper/get_user_role.dart';

Future<Map<String, String?>> getCurrentUserIdAndRole() async {
  String? userId = FirebaseServices.instance.userId;
  String? role = await getUserRole(userId);
  return {'userId': userId, 'role': role};
}
